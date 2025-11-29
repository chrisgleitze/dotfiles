#!/bin/bash
git add .
# echo 'Enter the commit message:'
# read commitMessage
# git commit -m "$commitMessage"
git commit -m "automated dev commit"
# echo 'Enter the name of the branch:'
# read branch
git push origin $branch
popd
