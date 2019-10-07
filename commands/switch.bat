@echo off

IF [%1] == [] (
    echo Missing branch name & echo usage: git admit new_branch_name
) ELSE (
    echo Creating new branch
    git branch %1

    echo Checking out new branch
    git checkout %1
)