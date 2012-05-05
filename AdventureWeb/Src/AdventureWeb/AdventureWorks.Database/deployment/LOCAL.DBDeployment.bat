:: AdventureWorks
@echo off

SET DIR=%~d0%~p0%

SET database.name="AdventureWorks"
SET sql.files.directory="..\db\"
SET server.database=".\Sql2008"
SET version.file="_BuildInfo.xml"
SET version.xpath="//buildInfo/version"
SET environment="LOCAL"
SET output=".\"
SET rh.path= "%DIR%..\..\..\Tools\RoundhousE\console\"
SET restore.path=%DIR%..\..\..\DatabaseBackups\
SET restore.name=AdventureWorks.bak

:: Run RH in RestoreRun mode
%rh.path%\rh.exe /s=%server.database% /d=%database.name% -f ..\db --debug /restore /rfp=%restore.path%\%restore.name% /simple

:: Run RH in normal mode
::%rh.path%\rh.exe /s=%server.database% /d=%database.name% -f ..\db --debug
