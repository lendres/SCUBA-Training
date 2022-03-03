@echo off
echo.
echo.
echo.
echo.
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

echo.
echo.
echo Make epss.
for %%x in (.\JPG\*.jpg) do call :make_eps %%x
goto :exit

:make_eps
set jpgfile=%1
set epsfile=%jpgfile:~0,-4%.eps
echo.
echo Input file: %jpgfile%
echo Ouput file: %epsfile%
call jpeg2ps.exe %jpgfile% > %epsfile%
goto :eof

:exit
echo.
echo.
echo Move epss to figures directory.
move /Y .\JPG\*.eps ..\
echo.
echo.
echo Copy jpgs to figures directory.
copy /Y .\JPG\*.jpg ..\

echo.
echo Done.
echo.

rem pause