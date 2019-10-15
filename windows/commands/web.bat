@echo off

for /f %%i in ('git remote get-url origin') do start %%i