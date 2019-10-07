@echo off

git --version

if not errorlevel 1 (
    echo Removing git aliases

    for /f %%f in ('dir /b .\commands') do (
        git config --global --unset alias.%%~nf
        @echo Removed git %%~nf
    )

    echo Purging install directory

    @RD /S /Q "c:\git-gud\"

    echo Uninstall complete
    pause
) else (
    echo Git doesn't appear to be available
    echo Try adding git to your PATH variable or running this command from the location where you normaly use git
    pause
)