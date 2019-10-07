@echo off

git --version

if not errorlevel 1 (
    echo Copying commands to install directory

    xcopy /s .\commands c:\git-gud\

    echo Creating git aliases

    for /f %%f in ('dir /b c:\git-gud') do (
        git config --global alias.%%~nf !'C:\Users\rbissett\Documents\gitScripts\%%~nf.bat'
        @echo Added git %%~nf
    )
    pause
) else (
    echo Git doesn't appear to be available
    echo Try adding git to your PATH variable or running this command from the location where you normaly use git
    pause
)