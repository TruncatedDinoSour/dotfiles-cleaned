#!/bin/sh

url="https://github.com/TruncatedDinosour/dotfiles-cleaned.git"
msg="update @ $(date)"
if [[ "$1" ]];
then
    msg="$1"
fi

echo "committing with message \"$msg\""
git rm --cached dotfiles/editors/vim/.vim/plugged/Alduin

if [[ ! -d ".git" ]];
then
    git init
    git add .
    git commit -m "$msg"
    git remote add origin "$url"
    git push -u origin master
    exit $?
else
    git add .
    git commit -m "$msg"
    git push -u origin master
fi

