#!/bin/bash
# git add .
# echo 'Enter the commit message:'
# read commitMessage
# git commit -m "$commitMessage"
# echo 'Enter the name of the branch:'
# read branch
# git push origin $branch
# read

git add .
git commit -m "automated dev commit"
git push origin $branch
popd
