#!/bin/bash

# github
fetch_origin() {
  # Get the current branch name
  current_branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  echo "Current branch: $current_branch"

  # Check if the current branch exists
  if [ -z "$current_branch" ]; then
    echo "You are not currently on a Git branch."
  fi

  local target_branch=${1:-"dev"}
  echo "Target branch: $target_branch"

  # Fetch the latest changes from the remote repository
  git fetch origin

  # Compare the current branch with the target branch
  commits=$(git rev-list --left-right --count HEAD...origin/$target_branch | awk '{print $2}')

  if [ "$commits" -gt 0 ]; then
    echo "Action required: merge or rebase ⚙️"
    git fetch origin ${target_branch}:${target_branch}
    git rebase ${target_branch}
    return 1 # return false
  else
    echo "No action needed ✅"
    return 0  # return true
  fi
}

create_pr() {
  local base
  local label
  local current_branch

  for arg in "$@"
  do
    case $arg in
      --base=*)
      base="${arg#*=}"
      shift
      ;;
      --label=*)
      label="${arg#*=}"
      shift
      ;;
      --current=*)
      current_branch="${arg#*=}"
      shift
      ;;
    esac
  done

  if [ -z "$current_branch" ]; then
    current_branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  fi

  # base
  base=${base:-"dev"}
  # label
  label=${label:-""}
  # current base
  current_branch=${current_branch}

  pr_command="gh pr create --base \"$base\" -a @me"

  if [ -n "$label" ]; then
    pr_command+=" --label \"$label\""
  fi
  echo $pr_command

  fetch_origin $base && eval $pr_command && git_path_pr
  # if [ "$p" = "dev" ]; then
  #   fetch_origin $base && gh pr create --base $current_branch -a='@me' --label $label && git_path_pr
  # else
  #   gh pr create --base $current_branch -a='@me' --label $label && git_path_pr
  # fi
}

git_path_pr() {
  gh pr view | awk '/^state:\t/{s=$2} /^url:\t/{u=$2} END{if(s=="OPEN") print u"/files"}' | pbcopy
}

branch_exists() {
  local branch_name=$1
  git show-ref --verify --quiet "refs/heads/$branch_name"
}

_create_branch_name_from_issue() {
  issue="$(gh issue list -a=@me | fzf)"
  issue_number=$(echo "$issue" | cut -f1)
  issue_title=$(echo "$issue" | cut -f3)
  issue_tag=$(echo "$issue" | cut -f4 | cut -d ',' -f 1 | tr -d ' ')

  if [ -z "$issue_title" ]; then
    echo "Issue title is empty. Canceling."
      return 1
  fi

  if [ -z "$issue_number" ]; then
    echo "Issue number is empty. Canceling."
      return 1
  fi

  if [ -z "$issue_tag" ]; then
    echo "Issue tag is empty. Canceling."
      return 1
  fi

  # Replace spaces with dashes and convert to lowercase
  issue_title=$(echo $issue_title | tr -cd 'A-Za-z ' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' | tr ' ' '-' | tr '[:upper:]' '[:lower:]')

  branch_name="${issue_tag}/issue-${issue_number}-${issue_title}"

  if branch_exists "$branch_name"; then
    git checkout "$branch_name"
  else
    git checkout -b "$branch_name"
  fi
}

_delete_branch() {
  read branch_name <<< "$(git fetch -p && _fzf_git_branch | sed 's/remotes\/origin\///')"
  git checkout dev
  echo "$branch_name"
  if branch_exists "$branch_name"; then
    git branch -D "$branch_name"
  fi

  if git show-ref --verify --quiet "refs/remotes/origin/${branch_name}"; then
    git push origin --delete "$branch_name"
  fi
}

# ===========================================================================================================================

# find shorthand
function f() {
	find . -name "$1" 2>&1 | grep -v 'Permission denied'
}

function remove() {
  for dir in "$@"; do
    find . -name "$dir" -type d -prune -print -exec rm -rf '{}' \;
  done
}

function remove_file() {
  for dir in "$@"; do
    find . -name "$dir" -type f -prune -print -exec rm -rf '{}' \;
  done
}

pip_requirements() {
  if test "$#" -eq 0
    then
      echo $'\nProvide at least one Python package name\n'
  else
    for package in "$@"
      do
        pip install $package
        pip freeze | grep -i $package >> requirements.txt
    done
  fi
}

function recursive_cd_fzf {
    local dir
    dir=$(ls -d */ | fzf)  # List directories and use fzf for interactive selection
    if [ -n "$dir" ]; then
        cd "$dir"           # Change directory to the selected one
        ls -d */ | fzf | xargs -I {} recursive_cd_fzf   # Recursive call with the new directory
    fi
}

function vs_edit_issue() {
   gh issue view $1 --json body --jq .body > /tmp/gh-$1.md
   cursor --wait /tmp/gh-$1.md
   gh issue edit $1 --body-file /tmp/gh-$1.md
}

myip() {
  ifconfig en0 | grep "inet " | awk '{print $2}'
}

copy_env() {
  local source_folder="$1"

  if [[ -z "$source_folder" ]]; then
    echo "Usage: copy_env <source_folder>"
    return 1
  fi

  declare -A seen_folders

 find "$source_folder" -type f \( -name ".env" -o -name "*.tfvars" \) | while read -r item; do

    # Extract root folder (first directory after 'source_folder/')
    rel_path="${item#${source_folder}/}"
    root_folder="${rel_path%%/*}"

    if [[ -z "${seen_folders[$root_folder]}" ]]; then
      echo "$root_folder"
      seen_folders["$root_folder"]=1
    fi

    dest="env/$rel_path"
    mkdir -p "$(dirname "$dest")"
    echo "Copying: $item to $dest"
    cp "$item" "$dest"
  done

  # Print folder count
  echo "Folder count: ${#seen_folders[@]}"
}

fzf_cd_wrapper() {
  zle fzf-cd-widget
}

coverage() {
  EXCLUDE_PATTERN=$(paste -sd'|' .coverignore) && go test -covermode=count -coverprofile=coverage.out $(go list ./... | grep -v integration_tests | egrep -v "(${EXCLUDE_PATTERN})\$\$")
}

clear_clipbaord() {
  pbcopy < /dev/null
}

# ===================================== gcp =====================================
gcp_project() {
  local projectId
  projectId=$(gcloud projects list --format='value(projectId)' | fzf)
  if [[ -n "$projectId" ]]; then
    gcloud config set project "$projectId"
    echo "Selected and set project: $projectId"
  else
    echo "No project selected."
  fi
}
