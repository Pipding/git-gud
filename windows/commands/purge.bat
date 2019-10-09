@echo off

IF [%1] == ["merged"] (
    echo This command will delete all local branches that have been merged into master & echo This includes local branches with no pushed changes

    :choice
    set /P c=Are you sure you want to continue? [Y/N]
    if /I "%c%" EQU "Y" goto :continueMerged
    if /I "%c%" EQU "N" goto :cancel
)

IF [%1] == ["deleted"] (
    echo This command will delete all local branches that have been deleted from the remote

    :choice
    set /P c=Are you sure you want to continue? [Y/N]
    if /I "%c%" EQU "Y" goto :continueDeleted
    if /I "%c%" EQU "N" goto :cancel
) ELSE (
    echo git purge requires an argument & echo Usage: & echo git purge deleted & echo git purge merged
    goto :cancel
)

:continueMerged
echo Switching to master
git checkout master
git pull
echo Pruning remote
git remote update origin --prune
echo Removing local branches with merged upstreams
for /f "usebackq" %%B in (`git branch --merged^|findstr /v /c:"* " /c:"master"`) do @git branch -d %%B
echo Remaining branches:
git branch -vv

:continueDeleted
echo Switching to master
git checkout master
git pull
echo Pruning remote
git remote prune origin
echo Removing local branches withoutupstreams
for /f "usebackq" %%B in (`git branch --merged^|findstr /v /c:"* " /c:"master"`) do @git branch -d %%B
echo Remaining branches:
git branch -vv

:cancel
