@echo off

REM IF [%1] == [merged] (
REM     echo This command will delete all local branches that have been merged into master & echo This includes local branches with no pushed changes
REM     goto :areYouSureMerged
REM )

REM IF [%1] == [deleted] (
    echo This command will delete all local branches that have been deleted from the remote
    goto :areYouSureDeleted
REM ) ELSE (
REM     echo git purge requires an argument & echo Usage: & echo git purge deleted & echo git purge merged
REM     goto :EOF
REM )


REM :areYouSureMerged
REM set /P mc=Are you sure you want to continue? [Y/N]
REM if /I "%mc%" EQU "Y" goto :continueMerged
REM if /I "%mc%" EQU "N" goto :EOF

:areYouSureDeleted
set /P dc=Are you sure you want to continue? [Y/N]
if /I "%dc%" EQU "Y" goto :continueDeleted
if /I "%dc%" EQU "N" goto :EOF


REM :continueMerged
REM echo Switching to master
REM git checkout master
REM if errorlevel 1 (
REM     goto :EOF
REM )
REM git pull
REM echo Pruning remote
REM git remote prune origin
REM git remote update origin --prune
REM echo Removing local branches with merged upstreams
REM for /f "usebackq" %%B in (`git branch --merged^|findstr /v /c:"* " /c:"master"`) do @git branch -d %%B
REM echo Remaining branches:
REM git branch -vv
REM goto :EOF

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