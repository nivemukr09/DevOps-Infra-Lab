#! /bin/bash

#change to the /q2 directory
cd /q2 || exit 1

#extract the archive
tar -xzf backup.tar.gz

#set permissions:0664 for files and 0775 for directories
find . -type f -exec chmod 0664 {} +
find . -type d -exec chmod 0775 {} +

#change ownership to user "anonymous" and gorup "no-team"
chown -R anonymous:no-team

#create fixed archive 
tar -czf /tmp/fixed-archive.tar.gz .