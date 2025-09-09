function git_delete_local_branches(){
    
    git fetch -p
    for branch in $(git branch -vv | grep ': gone]' | awk '{print $1}'); do
        echo "Deleting local branch: $branch"
        git branch -D $branch
    done
}
