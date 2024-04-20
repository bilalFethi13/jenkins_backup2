# Step 1: Handle untracked files and directories
untracked_files=$(git ls-files --others --exclude-standard)
if [ -n "$untracked_files" ]; then
    echo "Adding untracked files:"
    echo "$untracked_files"
    git add $untracked_files
    git commit -m "Automatically adding untracked files"
fi

# Step 2: Handle changes in submodules
git submodule foreach --recursive 'git add .; git commit -m "Automate commit of changes";'
git add .
git commit -m "Update submodule references with automated changes"

# Step 3: Push changes to remote
git push origin master
git submodule foreach --recursive 'git push origin HEAD'
