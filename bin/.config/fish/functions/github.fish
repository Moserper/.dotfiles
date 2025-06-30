function fetch_origin
    set current_branch (git symbolic-ref --short HEAD ^/dev/null)
    echo "Current branch: $current_branch"

    if test -z "$current_branch"
        echo "You are not currently on a Git branch."
    end

    set -l target_branch (count $argv) ; set target_branch (test $target_branch -gt 0; and echo $argv[1]; or echo "dev")
    echo "Target branch: $target_branch"

    git fetch origin

    set commits (git rev-list --left-right --count HEAD...origin/$target_branch | awk '{print $2}')

    if test "$commits" -gt 0
        echo "Action required: merge or rebase ⚙️"
        git fetch origin $target_branch:$target_branch
        git rebase $target_branch
        return 1
    else
        echo "No action needed ✅"
        return 0
    end
end

function create_pr
    set -l base ""
    set -l label ""
    set -l current_branch ""

    for arg in $argv
        switch $arg
            case --base=*
                set base (string replace -- '--base=' '' $arg)
            case --label=*
                set label (string replace -- '--label=' '' $arg)
            case --current=*
                set current_branch (string replace -- '--current=' '' $arg)
        end
    end

    if test -z "$current_branch"
        set current_branch (git symbolic-ref --short HEAD ^/dev/null)
    end

    if test -z "$base"
        set base "dev"
    end
    if test -z "$label"
        set label ""
    end

    set pr_command "gh pr create --base '$base' -a @me"
    if test -n "$label"
        set pr_command "$pr_command --label '$label'"
    end
    echo $pr_command

    fetch_origin $base; and eval $pr_command; and git_path_pr
end

function git_path_pr
    gh pr view | awk '/^state:\t/{s=$2} /^url:\t/{u=$2} END{if(s=="OPEN") print u"/files"}' | pbcopy
end

function branch_exists
    set -l branch_name $argv[1]
    git show-ref --verify --quiet "refs/heads/$branch_name"
end

function _create_branch_name_from_issue
    set issue (gh issue list -a=@me | fzf)
    set issue_number (echo $issue | cut -f1)
    set issue_title (echo $issue | cut -f3)
    set issue_tag (echo $issue | cut -f4 | cut -d ',' -f 1 | tr -d ' ')

    if test -z "$issue_title"
        echo "Issue title is empty. Canceling."
        return 1
    end
    if test -z "$issue_number"
        echo "Issue number is empty. Canceling."
        return 1
    end
    if test -z "$issue_tag"
        echo "Issue tag is empty. Canceling."
        return 1
    end

    set issue_title (echo $issue_title | tr -cd 'A-Za-z ' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' | tr ' ' '-' | tr '[:upper:]' '[:lower:]')
    set branch_name "$issue_tag/issue-$issue_number-$issue_title"

    branch_exists $branch_name; and git checkout $branch_name; or git checkout -b $branch_name
end

function _delete_branch
    set branch_name (git fetch -p; and _fzf_git_branch | sed 's/remotes\/origin\///')
    git checkout dev
    echo "$branch_name"
    branch_exists $branch_name; and git branch -D $branch_name
    git show-ref --verify --quiet "refs/remotes/origin/$branch_name"; and git push origin --delete $branch_name
end
