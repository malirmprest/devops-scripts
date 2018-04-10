#!/usr/bin/env bash

echo -- ahalan to git shrink repo ! --

echo -- checkout all branches --
for branch in `git branch -a | grep remotes | grep -v HEAD | grep -v master`; do
    git branch --track ${branch##*/} $branch
done

echo -- running git_find_in_history.sh --
sh git_find_in_history.sh

echo -- delete files from history --

declare -a FILES_NAMES=("docker/genie/api-manager/pattern-1-mprest/api-manager/wso2am-2.1.0.1506424836442.zip" 
"docker/genie/api-manager/docker-apim-2.1.0.4/dockerfiles/apim-analytics/files/jdk-8u141-linux-x64.tar.gz"
"docker/genie/api-manager/docker-apim-2.1.0.4/dockerfiles/apim-analytics/files/wso2am-analytics-2.1.0.zip"  
"docker/genie/api-manager/docker-apim-2.1.0.4/dockerfiles/apim/files/wso2am-2.1.0.zip"
"docker/genie/api-manager/docker-apim-2.1.0.4/dockerfiles/apim/files/jdk-8u141-linux-x64.tar.gz"
"docker/genie/api-manager/docker-apim-2.1.0.4/dockerfiles/apim-analytics/files/jdk1.8.0_141/jre/lib/rt.jar"
"docker/genie/api-manager/docker-apim-2.1.0.4/dockerfiles/apim-analytics/files/jdk1.8.0_141/jre/lib/amd64/libjfxwebkit.so"
"docker/genie/api-manager/docker-apim-2.1.0.4/dockerfiles/apim/files/jdk1.8.0_141/jre/lib/amd64/libjfxwebkit.so"
"docker/genie/api-manager/docker-apim-2.1.0.4/dockerfiles/apim/files/jdk1.8.0_141/jre/lib/rt.jar")
echo files_names is: ${FILES_NAMES[*]}

git filter-branch --tag-name-filter cat --index-filter "git rm -r --cached --ignore-unmatch ${FILES_NAMES[*]}" --prune-empty -f -- --all

rm -rf .git/refs/original/

git reflog expire --expire=now --all

git gc --prune=now

git gc --aggressive --prune=now

echo -- running git_find_in_history.sh --
sh git_find_in_history.sh

echo -- bye bye and see you soon, git shrink :D.. --