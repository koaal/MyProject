cd %~dp0
cd ..
call mvn clean install eclipse:clean eclipse:eclipse -Dmaven.test.skip=true
pause
cd bin