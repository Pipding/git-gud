# git-gud

Hey. Welcome to my collection of scripts and git aliases to make day-to-day git operations a little simpler.
It's Windows-only at the moment. Sorry about that. I'll fix it eventually.

# Installation

Clone the repository or download [a release](https://github.com/Pipding/git-gud/releases). Inside you'll find a "windows" folder containing an install file. Run this from your command line of choice or by double-clicking the file.

***Note: This install script uses git so make sure you have git available from wherever it runs. If you're want to double click the file, this means having git in your PATH variable.***

# Commands 

## git admit

A combination of `git add .` and `git commit -am ""`
This command adds all untracked files and commits them.

Example:

    git admit "Initial commit"

## git switch

A combination of `git branch` and `git checkout`
This command creates a new branch and checks it out.

Example:

    git switch add_linux_support
    
## git switchup

This is the git switch command but it also runs `git push --set-upstream origin branch_name` because let's be honest who bothers to remember that syntax?

Example:

    git switchup add_linux_support