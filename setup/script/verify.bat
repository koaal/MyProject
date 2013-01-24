cd %~dp0
cd ..
call mvn clean verify -P quick
pause
cd bin