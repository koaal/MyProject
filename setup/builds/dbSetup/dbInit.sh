#! /bin/sh

#
# Copyright (c) 1999, 2010 Tanuki Software, Ltd.
# http://www.tanukisoftware.com
# All rights reserved.
#
# This software is the proprietary information of Tanuki Software.
# You shall use it only in accordance with the terms of the
# license agreement you entered into with Tanuki Software.
# http://wrapper.tanukisoftware.org/doc/english/licenseOverview.html
#
# Java Service Wrapper sh script.  Suitable for starting and stopping
#  wrapped Java applications on UNIX platforms.
#

#-----------------------------------------------------------------------------
# These settings can be modified to fit the needs of your application
# Optimized for use with version 3.4.0 of the Wrapper.

# Application
APP_NAME="db Init"
APP_LONG_NAME="db Init"


# Priority at which to run the wrapper.  See "man nice" for valid priorities.
#  nice is only used if a priority is specified.
PRIORITY=

# Location of the pid file.
PIDDIR="."

# If uncommented, causes the Wrapper to be shutdown using an anchor file.
#  When launched with the 'start' command, it will also ignore all INT and
#  TERM signals.
#IGNORE_SIGNALS=true

# Wrapper will start the JVM asynchronously. Your application may have some
#  initialization tasks and it may be desirable to wait a few seconds
#  before returning.  For example, to delay the invocation of following
#  startup scripts.  Setting WAIT_AFTER_STARTUP to a positive number will
#  cause the start command to delay for the indicated period of time 
#  (in seconds).
# 
WAIT_AFTER_STARTUP=0

# If set, wait for the wrapper to report that the daemon has started
WAIT_FOR_STARTED_STATUS=true
WAIT_FOR_STARTED_TIMEOUT=120

# If set, the status, start_msg and stop_msg commands will print out detailed
#   state information on the Wrapper and Java processes.
#DETAIL_STATUS=true

# If specified, the Wrapper will be run as the specified user.
# IMPORTANT - Make sure that the user has the required privileges to write
#  the PID file and wrapper.log files.  Failure to be able to write the log
#  file will cause the Wrapper to exit without any way to write out an error
#  message.
# NOTE - This will set the user which is used to run the Wrapper as well as
#  the JVM and is not useful in situations where a privileged resource or
#  port needs to be allocated prior to the user being changed.
#RUN_AS_USER=

# The following two lines are used by the chkconfig command. Change as is
#  appropriate for your application.  They should remain commented.
# chkconfig: 2345 20 80
# description: @app.long.name@

# When installing on On Mac OSX platforms, the following domain will be used to
#  prefix the plist file name.
PLIST_DOMAIN=org.tanukisoftware.wrapper
 
# Initialization block for the install_initd and remove_initd scripts used by
#  SUSE linux distributions.
### BEGIN INIT INFO
# Provides: @app.name@
# Required-Start: $local_fs $network $syslog
# Should-Start: 
# Required-Stop:
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: @app.long.name@
# Description: @app.description@
### END INIT INFO

# Do not modify anything beyond this point
#-----------------------------------------------------------------------------

# Required for HP-UX Startup
if [ `uname -s` = "HP-UX" -o `uname -s` = "HP-UX64" ] ; then
        PATH=$PATH:/usr/bin
fi

# Get the fully qualified path to the script
case $0 in
    /*)
        SCRIPT="$0"
        ;;
    *)
        PWD=`pwd`
        SCRIPT="$PWD/$0"
        ;;
esac

# Resolve the true real path without any sym links.
CHANGED=true
while [ "X$CHANGED" != "X" ]
do
    # Change spaces to ":" so the tokens can be parsed.
    SAFESCRIPT=`echo $SCRIPT | sed -e 's; ;:;g'`
    # Get the real path to this script, resolving any symbolic links
    TOKENS=`echo $SAFESCRIPT | sed -e 's;/; ;g'`
    REALPATH=
    for C in $TOKENS; do
        # Change any ":" in the token back to a space.
        C=`echo $C | sed -e 's;:; ;g'`
        REALPATH="$REALPATH/$C"
        # If REALPATH is a sym link, resolve it.  Loop for nested links.
        while [ -h "$REALPATH" ] ; do
            LS="`ls -ld "$REALPATH"`"
            LINK="`expr "$LS" : '.*-> \(.*\)$'`"
            if expr "$LINK" : '/.*' > /dev/null; then
                # LINK is absolute.
                REALPATH="$LINK"
            else
                # LINK is relative.
                REALPATH="`dirname "$REALPATH"`""/$LINK"
            fi
        done
    done

    if [ "$REALPATH" = "$SCRIPT" ]
    then
        CHANGED=""
    else
        SCRIPT="$REALPATH"
    fi
done

# Change the current directory to the location of the script
cd "`dirname "$REALPATH"`"
REALDIR=`pwd`

# If the PIDDIR is relative, set its value relative to the full REALPATH to avoid problems if
#  the working directory is later changed.
FIRST_CHAR=`echo $PIDDIR | cut -c1,1`
if [ "$FIRST_CHAR" != "/" ]
then
    PIDDIR=$REALDIR/$PIDDIR
fi


# Process ID
ANCHORFILE="$PIDDIR/$APP_NAME.anchor"
STATUSFILE="$PIDDIR/$APP_NAME.status"
JAVASTATUSFILE="$PIDDIR/$APP_NAME.java.status"
PIDFILE="$PIDDIR/$APP_NAME.pid"
LOCKDIR="/var/lock/subsys"
LOCKFILE="$LOCKDIR/$APP_NAME"
pid=""

# Resolve the location of the 'ps' command
PSEXE="/usr/ucb/ps"
    if [ ! -x "$PSEXE" ]
    then
        PSEXE="/usr/bin/ps"
        if [ ! -x "$PSEXE" ]
        then
            PSEXE="/bin/ps"
            if [ ! -x "$PSEXE" ]
            then
                echo "Unable to locate 'ps'."
                echo "Please report this message along with the location of the command on your system."
                exit 1
            fi
        fi
    fi

# Resolve the os
DIST_OS=`uname -s | tr [A-Z] [a-z] | tr -d ' '`
case "$DIST_OS" in
    'sunos')
        DIST_OS="solaris"
        ;;
    'hp-ux' | 'hp-ux64')
        # HP-UX needs the XPG4 version of ps (for -o args)
        DIST_OS="hpux"
        UNIX95=""
        export UNIX95   
        ;;
    'darwin')
        DIST_OS="macosx"
        ;;
    'unix_sv')
        DIST_OS="unixware"
        ;;
    'os/390')
        DIST_OS="zos"
        ;;
esac

# Resolve the architecture
if [ "$DIST_OS" = "macosx" ]
then
    DIST_ARCH="universal"
    APP_PLIST_BASE=${PLIST_DOMAIN}.${APP_NAME}
    APP_PLIST=${APP_PLIST_BASE}.plist
else
    DIST_ARCH=
    DIST_ARCH=`uname -p 2>/dev/null | tr [A-Z] [a-z] | tr -d ' '`
    if [ "X$DIST_ARCH" = "X" ]
    then
        DIST_ARCH="unknown"
    fi
    if [ "$DIST_ARCH" = "unknown" ]
    then
        DIST_ARCH=`uname -m 2>/dev/null | tr [A-Z] [a-z] | tr -d ' '`
    fi
    case "$DIST_ARCH" in
        'athlon' | 'i386' | 'i486' | 'i586' | 'i686')
            DIST_ARCH="x86"
            if [ "${DIST_OS}" = "solaris" ] ; then
                DIST_BITS=`isainfo -b`
            else
                DIST_BITS="32"
            fi
            ;;
        'amd64' | 'x86_64')
            DIST_ARCH="x86"
            DIST_BITS="64"
            ;;
        'ia32')
            DIST_ARCH="ia"
            DIST_BITS="32"
            ;;
        'ia64' | 'ia64n' | 'ia64w')
            DIST_ARCH="ia"
            DIST_BITS="64"
            ;;
        'ip27')
            DIST_ARCH="mips"
            DIST_BITS="32"
            ;;
        'power' | 'powerpc' | 'power_pc' | 'ppc64')
            if [ "${DIST_ARCH}" = "ppc64" ] ; then
                DIST_BITS="64"
            else
                DIST_BITS="32"
            fi
            DIST_ARCH="ppc"
            if [ "${DIST_OS}" = "aix" ] ; then
                if [ `getconf KERNEL_BITMODE` -eq 64 ]; then
                    DIST_BITS="64"
                else
                    DIST_BITS="32"
                fi
            fi
            ;;
        'pa_risc' | 'pa-risc')
            DIST_ARCH="parisc"
            if [ `getconf KERNEL_BITS` -eq 64 ]; then
                DIST_BITS="64"
            else
                DIST_BITS="32"
            fi    
            ;;
        'sun4u' | 'sparcv9' | 'sparc')
            DIST_ARCH="sparc"
            DIST_BITS=`isainfo -b`
            if [ ! -f /usr/lib/libm.so.2 -a "${DIST_BITS}" = "32" ]; then
                ln -s /usr/lib/libm.so.1 /usr/lib/libm.so.2
            elif [ ! -f /usr/lib/sparcv9/libm.so.2 -a "${DIST_BITS}" = "64" ]; then
                ln -s /usr/lib/sparcv9/libm.so.1 /usr/lib/sparcv9/libm.so.2
            fi
            ;;
        '9000/800' | '9000/785')
            DIST_ARCH="parisc"
            if [ `getconf KERNEL_BITS` -eq 64 ]; then
                DIST_BITS="64"
            else
                DIST_BITS="32"
            fi
            ;;
        '2097')
            DIST_ARCH="390"
            DIST_BITS="32"
            ;;
    esac
fi

# OSX always places Java in the same location so we can reliably set JAVA_HOME
if [ "$DIST_OS" = "macosx" ]
then
    if [ -z "$JAVA_HOME" ]; then
        JAVA_HOME="/Library/Java/Home"; export JAVA_HOME
    fi
fi

# Test Echo
ECHOTEST=`echo -n "x"`
if [ "$ECHOTEST" = "x" ]
then
    ECHOOPT="-n "
else
    ECHOOPT=""
fi

outputFile() {
    if [ -f "$1" ]
    then
        echo "  $1 (Found but not executable.)";
    else
        echo "  $1"
    fi
}


# Build the nice clause
if [ "X$PRIORITY" = "X" ]
then
    CMDNICE=""
else
    CMDNICE="nice -$PRIORITY"
fi

# Build the anchor file clause.
if [ "X$IGNORE_SIGNALS" = "X" ]
then
   ANCHORPROP=
   IGNOREPROP=
else
   ANCHORPROP=wrapper.anchorfile=\"$ANCHORFILE\"
   IGNOREPROP=wrapper.ignore_signals=TRUE
fi

# Build the status file clause.
if [ "X$DETAIL_STATUS$WAIT_FOR_STARTED_STATUS" = "X" ]
then
   STATUSPROP=
else
   STATUSPROP="wrapper.statusfile=\"$STATUSFILE\" wrapper.java.statusfile=\"$JAVASTATUSFILE\""
fi

if [ ! -n "$WAIT_FOR_STARTED_STATUS" ]
then
    WAIT_FOR_STARTED_STATUS=true
fi

if [ $WAIT_FOR_STARTED_STATUS = true ] ; then
    DETAIL_STATUS=true
fi


# Build the lock file clause.  Only create a lock file if the lock directory exists on this platform.
LOCKPROP=
if [ -d $LOCKDIR ]
then
    if [ -w $LOCKDIR ]
    then
        LOCKPROP=wrapper.lockfile=\"$LOCKFILE\"
    fi
fi

checkUser() {
    # $1 touchLock flag
    # $2 command

    # Check the configured user.  If necessary rerun this script as the desired user.
    if [ "X$RUN_AS_USER" != "X" ]
    then
        # Resolve the location of the 'id' command
        IDEXE="/usr/xpg4/bin/id"
        if [ ! -x "$IDEXE" ]
        then
            IDEXE="/usr/bin/id"
            if [ ! -x "$IDEXE" ]
            then
                echo "Unable to locate 'id'."
                echo "Please report this message along with the location of the command on your system."
                exit 1
            fi
        fi
    
        if [ "`$IDEXE -u -n`" = "$RUN_AS_USER" ]
        then
            # Already running as the configured user.  Avoid password prompts by not calling su.
            RUN_AS_USER=""
        fi
    fi
    if [ "X$RUN_AS_USER" != "X" ]
    then
        # If LOCKPROP and $RUN_AS_USER are defined then the new user will most likely not be
        # able to create the lock file.  The Wrapper will be able to update this file once it
        # is created but will not be able to delete it on shutdown.  If $2 is defined then
        # the lock file should be created for the current command
        if [ "X$LOCKPROP" != "X" ]
        then
            if [ "X$1" != "X" ]
            then
                # Resolve the primary group 
                RUN_AS_GROUP=`groups $RUN_AS_USER | awk '{print $3}' | tail -1`
                if [ "X$RUN_AS_GROUP" = "X" ]
                then
                    RUN_AS_GROUP=$RUN_AS_USER
                fi
                touch $LOCKFILE
                chown $RUN_AS_USER:$RUN_AS_GROUP $LOCKFILE
            fi
        fi

        # Still want to change users, recurse.  This means that the user will only be
        #  prompted for a password once. Variables shifted by 1
        # 
        # Use "runuser" if this exists.  runuser should be used on RedHat in preference to su.
        #
        if test -f "/sbin/runuser"
        then
            /sbin/runuser - $RUN_AS_USER -c "\"$REALPATH\" $2"
        else
            su - $RUN_AS_USER -c "\"$REALPATH\" $2"
        fi

        # Now that we are the original user again, we may need to clean up the lock file.
        if [ "X$LOCKPROP" != "X" ]
        then
            getpid
            if [ "X$pid" = "X" ]
            then
                # Wrapper is not running so make sure the lock file is deleted.
                if [ -f "$LOCKFILE" ]
                then
                    rm "$LOCKFILE"
                fi
            fi
        fi

        exit 0
    fi
}

macosxuser() {
    # The daemon has been installed.
    echo "Starting $APP_LONG_NAME.  Detected Mac OSX and installed launchd daemon."
    if [ `id | sed 's/^uid=//;s/(.*$//'` != "0" ] ; then       
        echo "Must be root to perform this action."
        exit 1
    fi
    
    export ANT_HOME=${PWD#*/}/ant
    sudo chmod a+x ant/bin/ant
    ant/bin/ant init-db
}

user() {
    export ANT_HOME=${PWD#*/}/ant
    sudo chmod a+x ant/bin/ant
    ant/bin/ant init-user
}
 


macosxall() {
    # The daemon has been installed.
    echo "Starting $APP_LONG_NAME.  Detected Mac OSX and installed launchd daemon."
    if [ `id | sed 's/^uid=//;s/(.*$//'` != "0" ] ; then       
        echo "Must be root to perform this action."
        exit 1
    fi
    
    export ANT_HOME=${PWD#*/}/ant
    sudo chmod a+x ant/bin/ant
    ant/bin/ant init-all
}

all(){

 	export ANT_HOME=${PWD#*/}/ant
    sudo chmod a+x ant/bin/ant
    ant/bin/ant init-all
}

dac(){
    export ANT_HOME=${PWD#*/}/ant
    sudo chmod a+x ant/bin/ant
    ant/bin/ant dac-db-init
}


simulator(){
    export ANT_HOME=${PWD#*/}/ant
    sudo chmod a+x ant/bin/ant
    ant/bin/ant simulator-data
}

case "$1" in

    'user')
        if [ "$DIST_OS" = "macosx" -a -f "/Library/LaunchDaemons/${APP_PLIST}" ] ; then
            macosxuser
        else
            checkUser touchlock $1
            user
        fi
        ;;
        
     'all')
        if [ "$DIST_OS" = "macosx" -a -f "/Library/LaunchDaemons/${APP_PLIST}" ] ; then
            macosxall
        else
            checkUser touchlock $1
            all
        fi
        ;;
        
      'dac')
        if [ "$DIST_OS" = "macosx" -a -f "/Library/LaunchDaemons/${APP_PLIST}" ] ; then
            macosxall
        else
            checkUser touchlock $1
            dac
        fi
        ;;
        
      'simulator')
        if [ "$DIST_OS" = "macosx" -a -f "/Library/LaunchDaemons/${APP_PLIST}" ] ; then
            macosxall
        else
            checkUser touchlock $1
            simulator
        fi
        ;;
    *)
        echo "Usage: $0 {  user | all | dac | simulator}"
        exit 1
        ;;
esac

exit 0