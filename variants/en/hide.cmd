echo off
title File hide

set usr=-1
set maskfile=%1
set realfile=%2
call :strLen maskfile masklen
call :strLen realfile reallen
if not [%maskfile%]==[] (
	if not [%realfile%]==[] (
		set usr=0
	)
)
goto zero

:zero
cls
echo *****************************************************
echo *                                                   *
echo *                     Hide file                     *
echo *                                                   *
echo *****************************************************
echo Use media file for mask
echo Dont use text, compressed file for mask
echo Use 7zip, winrar to open hidden files
echo -------------------

if %usr%==0 goto execute
if %usr%==1 goto end

set /p maskfile="Mask file        : "
set /p realfile="Real file/folder : "

:execute
set outputFile=%cd%\%random%_thisisnot_%maskfile%
set tempFile=%temp%\tempCompressedFile.zip

echo Working...
powershell Compress-Archive "%realfile%" %tempFile% -Force
copy /b "%maskfile%"+"%tempFile%" %outputFile%
rem del %tempFile%

set usr=1
goto zero

:end
echo Output file: %outputFile%
pause > nul