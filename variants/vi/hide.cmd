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
echo *                     An file                       *
echo *                                                   *
echo *****************************************************
echo Tot nhat la dung cac file media (hinh anh, am thanh, video) lam vo boc
echo Dung dung file text, zip lam vo boc
echo Dung 7zip, winrar de mo file an
echo -------------------

if %usr%==0 goto execute
if %usr%==1 goto end

set /p maskfile="Vo boc file       : "
set /p realfile="File/thu muc that : "

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