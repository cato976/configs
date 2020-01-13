#!/bin/bash
# custom functions
# get me the url of the changes that have just been pushed

if [ $? -eq 0 ]; then
    github_url=`git remote -v | awk '/fetch/{print $2}' | sed -Ee 's#(git@|git://)#http://#' -e 's@com:@com/@' -e 's%\.git$%%'`;
    branch_name=`git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3`;
    pr_url=$github_url"/compare/master..."$branch_name
    start chrome $pr_url;
else
    echo 'failed to open a pull request.';
fi
