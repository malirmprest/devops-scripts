#! /bin/bash
#"Need to make sure that repoB which is the destination repo exists"
#Usage:
# ./DuplicateGit.sh {source_repo} {remote_repo}
# ./DuplicateGit.sh https://mprest2.visualstudio.com/Infra/_git/genie-bootstrap https://tfs2018a/DefaultCollection/Infra/_git/genie-bootstrap
repoA=${1:-https://mprest2.visualstudio.com/DevOps/_git/devops}
repoB=${2:-https://github.com/shacharaj/test.git}
echo repoA=$repoA
echo repoB=$repoB


git clone --mirror $repoA tempdir
cd tempdir
git tag
git branch -a
git remote rm origin
git remote add origin $repoB
git push origin --all
git push --tags
cd ../ && rm -rf tempdir
