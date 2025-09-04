@echo off


SET BUILDER="C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\MSBuild\Current\Bin\MSBuild.exe"
SET SOLUTION=".\ArtiDiag900.vcxproj"

@echo ============================================ 开始编译 ==========================================
%BUILDER% %SOLUTION% /t:Rebuild /p:Configuration=Debug /p:Platform=x64

if "%ERRORLEVEL%"=="1" goto TAG_FAILED
goto TAG_SUCCESS

:TAG_FAILED
@echo ==========================================  工程编译失败  ======================================
pause
goto TAG_EXIST

:TAG_SUCCESS
@echo ==========================================  工程编译成功  ======================================
pause

:TAG_EXIST