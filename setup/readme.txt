1)  changes values in build.properties
		.change maven.home path to your own path
		.change ws.folder path to your own workspace path


2)  changes values in builds/dbSetup/build.properties
		.change db.root.username if necessary
		.change db.root.username if necessary
		
3)  Use
	    .run script/package.bat or script/quick-package.bat
	    
4)  DB init
		.builds/dbSetup/dbInit-user.bat to init Sysuser on windows 
	    .builds/dbSetup/dbInit.sh  user|all|dac on linux
	    
5)  ran manger
		.builds/package/manager/bin/start.bat on windows
	    .builds/package/manager/bin/manager.sh start|console|stop on linux

