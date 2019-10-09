@echo off

IF [%1] == ["merged"] (
    echo This command will delete all local branches that have been merged & echo This may include local branches with un-pushed changes

    :choice
    set /P c=Are you sure you want to continue? [Y/N]
    if /I "%c%" EQU "Y" goto :continueMerged
    if /I "%c%" EQU "N" goto :cancel
) ELSE (
    echo This command will delete all local branches that have been merged & echo This may include local branches with un-pushed changes

    :choice
    set /P c=Are you sure you want to continue? [Y/N]
    if /I "%c%" EQU "Y" goto :continueDeleted
    if /I "%c%" EQU "N" goto :cancel
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
git remote update origin --prune
echo Removing local branches with merged upstreams
for /f "usebackq" %%B in (`git branch --merged^|findstr /v /c:"* " /c:"master"`) do @git branch -d %%B
echo Remaining branches:
git branch -vv

:cancel
