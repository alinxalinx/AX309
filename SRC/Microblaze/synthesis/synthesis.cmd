@echo off

if exist xst rmdir /s /q xst

echo "xst -ifn "system_xst.scr" -intstyle silent"

echo "Running XST synthesis ..."

xst -ifn "system_xst.scr" -intstyle silent
if errorlevel 1 exit 1

echo "XST completed"

if exist xst rmdir /s /q xst
exit 0
