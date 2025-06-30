function clear_clipbaord
    pbcopy < /dev/null
end

function myip
    ifconfig en0 | grep "inet " | awk '{print $2}'
end

function pip_requirements
    if test (count $argv) -eq 0
        echo '\nProvide at least one Python package name\n'
    else
        for package in $argv
            pip install $package
            pip freeze | grep -i $package >> requirements.txt
        end
    end
end

function remove
    for dir in $argv
        find . -name "$dir" -type d -prune -print -exec rm -rf '{}' \;
    end
end

function remove_file
    for dir in $argv
        find . -name "$dir" -type f -prune -print -exec rm -rf '{}' \;
    end
end

function coverage
    set EXCLUDE_PATTERN (paste -sd'|' .coverignore)
    go test -covermode=count -coverprofile=coverage.out (go list ./... | grep -v integration_tests | egrep -v "($EXCLUDE_PATTERN)\$\$")
end

function copy_env
    set -l source_folder $argv[1]
    if test -z "$source_folder"
        echo "Usage: copy_env <source_folder>"
        return 1
    end
    set -l seen_folders
    find "$source_folder" -type f \( -name ".env" -o -name "*.tfvars" \) | while read -l item
        set rel_path (string replace -- "$source_folder/" "" $item)
        set root_folder (string split -m1 "/" $rel_path)[1]
        if not contains $root_folder $seen_folders
            echo "$root_folder"
            set -a seen_folders $root_folder
        end
        set dest "env/$rel_path"
        mkdir -p (dirname $dest)
        echo "Copying: $item to $dest"
        cp "$item" "$dest"
    end
    echo "Folder count: "(count $seen_folders)
end
