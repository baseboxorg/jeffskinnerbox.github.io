#!/usr/bin/env bash

# **** THIS DOESN'T WORK YET ****   **** THIS DOESN'T WORK YET ****

# This script is used to start & stop the local hosting of the blog.
# It performs the following steps:
#
#   Starting
#       Executes "./bin/activate" command to start the Python virtual environment
#       Execute "make start" command to start the Pelican and TiddlyWiki web servers
#
#   Stopping
#       Execute "make stop" to stop the web servers
#       Execute "deactivate" to release the Python virtual environment


USAGE="Usage: `basename $0` start | stop | status"

# Parse command line options
if [ $1 = "start" ]; then
    echo "Starting blog..."
    source ./bin/activate
    #export PATH
    make start
    echo  "Blog has been started."
elif [ $1 = "stop" ]; then
    echo "Stopping blog..."
    make stop
    deactivate
    echo "Blog has been stopped"
elif [ $1 = "status" ]; then
    echo "pelican.pid = " `cat pelican.pid`
    echo "srv.pid = " `cat srv.pid`
    echo "tiddlywiki.pid = " `cat tiddlywiki.pid`
else 
    echo $USAGE
fi
