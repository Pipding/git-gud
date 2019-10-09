@echo off

echo This command will delete all local branches that aren't in the remote repository & echo This includes any local branches you haven't yet pushed

:choice
set /P c=Are you sure you want to continue[Y/N]?
if /I "%c%" EQU "Y" goto :continue
if /I "%c%" EQU "N" goto :cancel

:continue
echo Switching to master
git checkout master
git pull
echo Pruning remote
git remote update origin --prune
echo Removing local branches with missing upstreams
for /f "usebackq" %%B in (`git branch --merged^|findstr /v /c:"* " /c:"master"`) do @git branch -d %%B
echo Remaining branches:
git branch -vv

:cancel
