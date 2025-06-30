function gcp_project
    set projectId (gcloud projects list --format='value(projectId)' | fzf)
    if test -n "$projectId"
        gcloud config set project "$projectId"
        echo "Selected and set project: $projectId"
    else
        echo "No project selected."
    end
end
