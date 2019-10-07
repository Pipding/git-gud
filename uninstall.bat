@echo off

echo Removing git aliases

for /f %%f in ('dir /b .\commands') do (
    git config --global --unset alias.%%~nf
    @echo Removed git %%~nf
)

echo Purging install directory

@RD /S /Q "c:\git-gud\"

echo Uninstall complete