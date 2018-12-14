@echo off
SET THEFILE=d:\school\codelabs\pascal\worksh~3\hargap~1.exe
echo Linking %THEFILE%
c:\dev-pas\bin\ldw.exe  D:\School\Codelabs\Pascal\WORKSH~3\rsrc.o -s   -b base.$$$ -o d:\school\codelabs\pascal\worksh~3\hargap~1.exe link.res
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occured while assembling %THEFILE%
goto end
:linkend
echo An error occured while linking %THEFILE%
:end
