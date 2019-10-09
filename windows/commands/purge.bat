@echo off

IF [%1] == [merged] (
    echo This command will delete all local branches that have been merged into master & echo This includes local branches with no pushed changes
    goto :areYouSureMerged
)

IF [%1] == [deleted] (
    echo This command will delete all local branches that have been deleted from the remote
    goto :areYouSureDeleted
) ELSE (
    echo git purge requires an argument & echo Usage: & echo git purge deleted & echo git purge merged
    goto :EOF
)


:areYouSureMerged
set /P mc=Are you sure you want to continue? [Y/N]
if /I "%mc%" EQU "Y" goto :continueMerged
if /I "%mc%" EQU "N" goto :EOF

:areYouSureDeleted
set /P dc=Are you sure you want to continue? [Y/N]
if /I "%dc%" EQU "Y" goto :continueDeleted
if /I "%dc%" EQU "N" goto :EOF


:continueMerged
echo Switching to master
git checkout master
if errorlevel 1 (
    goto :EOF
)
git pull
echo Pruning remote
git remote prune origin
git remote update origin --prune
echo Removing local branches with merged upstreams
for /f "usebackq" %%B in (`git branch --merged^|findstr /v /c:"* " /c:"master"`) do @git branch -d %%B
echo Remaining branches:
git branch -vv
goto :EOF

:continueDeleted
echo Switching to master
git checkout master
if errorlevel 1 (
    goto :EOF
)
git pull
echo Pruning remote
git remote prune origin
git remote update origin --prune
echo Removing local branches without upstreams
powershell -Command "& {git branch --list --format '%%(if:equals=[gone])%%(upstream:track)%%(then)%%(refname:short)%%(end)' | ? { $_ -ne '' } | %% { git branch -D $_ }}"
echo Remaining branches:
git branch -vv
goto :EOF