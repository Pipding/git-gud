@echo off

echo Copying commands to install directory

xcopy /s .\commands c:\git-gud\

echo Creating git aliases

for /f %%f in ('dir /b c:\git-gud') do (
    git config --global alias.%%~nf !'C:\Users\rbissett\Documents\gitScripts\%%~nf.bat'
    @echo Added git %%~nf
)