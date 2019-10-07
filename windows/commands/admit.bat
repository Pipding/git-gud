@echo off

IF [%1] == []  (
    echo Missing commit message & echo usage: git admit "message"
) ELSE (
    echo Adding unstaged changes
    git add .

    echo Committing changes
    git commit -am %1
)