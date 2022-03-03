@echo off
title Convert a Single EPS File to a PDF File

echo.
echo.
echo.
echo.
echo.
echo.

set file="%CD%\EPS\%1"
echo File name:
echo %file%

echo.
echo.
echo Process file.
rem epstopdf.exe .\EPS\BitLabels-RC.EPS
epstopdf.exe %file%


echo.
echo.
echo Move newly created pdfs and copy original source files to the figures directory.
echo.
echo.

rem There should only be the one pdf created, so this is an easy way of doing this.
move /Y .\EPS\*.pdf ..\

echo.
echo.
echo Copy epss in root directory.
copy /Y %file% ..\