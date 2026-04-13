function recursive_cd_fzf
    set dir (ls -d */ | fzf)
    if test -n "$dir"
        cd "$dir"
        ls -d */ | fzf | xargs -I {} recursive_cd_fzf
    end
end

function fzf_cd_wrapper
    fzf-cd-widget
end

function f
    find . -name "$argv[1]" 2>&1 | grep -v 'Permission denied'
end
