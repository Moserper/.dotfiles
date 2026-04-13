function vs_edit_issue
    gh issue view $argv[1] --json body --jq .body > /tmp/gh-$argv[1].md
    cursor --wait /tmp/gh-$argv[1].md
    gh issue edit $argv[1] --body-file /tmp/gh-$argv[1].md
end
