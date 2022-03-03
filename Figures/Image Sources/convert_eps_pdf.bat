@echo off
title Convert EPS Files to PDFs

echo This file is used to convert the eps graphics files to pdf files.
echo When creating a pdf document out of a tex
echo only pdf and jpg files can be used to import graphics.
echo.
echo This batch file needs the program epstopdf.exe which is
echo part of the MiKTeX installation (for Windows).  epstopdf.exe must be
echo located in part of the search path (or same directory as this file).
echo.
echo The output is 1 pdf file for every eps file.  The pdf files have
echo the same base name as the eps files but with the pdf file extension.
echo =======================================================================
echo.

@echo off

rem Create a batch file that runs the epstopdf.exe.
echo echo processing %%1 > process.bat
echo epstopdf.exe %%1 >> process.bat

rem Create a file that will process subdirectories of this directory the same way this file
rem processes files in this directory.
rem NOTE: Directories and file cannot contain spaces.
echo echo processing directory %%1 > processdir.bat
echo for %%%%x in (.\EPS\%%1\*.eps) do call process.bat %%%%x >> processdir.bat

echo.
echo.
echo Process the eps files in this directory.
for %%x in (.\EPS\*.eps) do call process.bat %%x

echo.
echo.
echo Run batch file that processes directories.
rem Directories are processed last under the assumption that most figures are added to the root directory and,
rem therefore, the newest figures are more likely to have been added to that directory.
for /F %%x in ('call dir .\EPS /ad /b') do call processdir.bat %%x %%y


echo.
echo.
echo Move newly created pdfs and copy original source files to the figures directory.

rem Root directory.
echo.
echo.
echo Move pdfs in root directory.
move /Y .\EPS\*.pdf ..\
echo.
echo.
echo Copy epss in root directory.
copy /Y .\EPS\*.eps ..\

rem Sub directories.
echo.
echo.
echo Create sub directories.
for /F %%x in ('call dir .\EPS /ad /b') do call mkdir ..\%%x
echo.
echo.
echo Move pdfs in sub directories.
for /F %%x in ('call dir .\EPS /ad /b') do call move /Y .\EPS\%%x\*.pdf ..\%%x
echo.
echo.
echo Copy epss in sub directories.
for /F %%x in ('call dir .\EPS /ad /b') do call copy /Y .\EPS\%%x\*.eps ..\%%x


del process.bat
del processdir.bat

rem pause