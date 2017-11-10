#!/bin/bash
 
# set to off to activate deletion
# set to on to disable deletion
TRACE_ONLY=on
 
function delete_file {
  path_to_delete=$1
  [ "$path_to_delete" = "/" ] && \
    echo "FATAL: root path identified" return -1
 
  [ -n "$path_to_delete" ] && \
  [ -f "$path_to_delete" ] && \
    echo "  deleting \"$path_to_delete\"... " && \
    [ "$TRACE_ONLY" = "off" ] && \
    rm -f "$path_to_delete";
}
 
function delete_folder {
  path_to_delete=$1
  [ "$path_to_delete" = "/" ] && \
    echo "FATAL: root path identified" return -1
 
  [ -n "$path_to_delete" ] && \
  [ -d "$path_to_delete" ] && \
    echo "  deleting \"$path_to_delete\"... " && \
    [ "$TRACE_ONLY" = "off" ] && \
    rm -rf "$path_to_delete";
}
 
echo "# Remove Docker"
[ -f "/Applications/Docker.app/Contents/MacOS/Docker" ] && \
  [ "$TRACE_ONLY" = "off" ] && \
  /Applications/Docker.app/Contents/MacOS/Docker --uninstall
 
for i in $(ls "/Users/"); do
{
  delete_folder "/Users/$i/Library/Application\ Support/Kitematic"
} done;
delete_folder "/Applications/Docker"
delete_folder "/Applications/boot2docker"
delete_file "/usr/local/bin/docker"
delete_file "/usr/local/bin/boot2docker"
delete_file "/usr/local/bin/docker-compose*"
delete_file "/usr/local/bin/docker-machine*"
delete_file "/usr/local/bin/docker-machine-driver*"
 
for i in $(ls "/Users/"); do 
{
  delete_folder "/Users/$i/.docker"
  delete_folder "/Users/$i/.boot2docker"
  delete_file "/Users/$i/.ssh/id_boot2docker*"
} done;
 
echo "# Remove boot2docker"
delete_folder "/usr/local/share/boot2docker"
delete_file "/usr/local/share/boot2docker/boot2docker.iso"
delete_file "/private/var/db/receipts/io.boot2dockeriso.pkg.boot2dockeriso.bom"
delete_file "/private/var/db/receipts/io.boot2dockeriso.pkg.boot2dockeriso.plist"
delete_file "/private/var/db/receipts/io.docker.pkg.docker.bom"
delete_file "/private/var/db/receipts/io.docker.pkg.docker.plist"
delete_file "/private/var/db/receipts/io.docker.pkg.dockercompose.bom"
delete_file "/private/var/db/receipts/io.docker.pkg.dockercompose.plist"
delete_file "/private/var/db/receipts/io.docker.pkg.dockermachine.bom"
delete_file "/private/var/db/receipts/io.docker.pkg.dockermachine.plist"
delete_file "/private/var/db/receipts/io.docker.pkg.dockerquickstartterminalapp.bom"
delete_file "/private/var/db/receipts/io.docker.pkg.dockerquickstartterminalapp.plist"
delete_file "/private/var/db/receipts/io.docker.pkg.kitematicapp.bom"
delete_file "/private/var/db/receipts/io.docker.pkg.kitematicapp.plist"
delete_file "/private/var/run/docker.sock"
 
echo "# Remove docker packages"
[ "$TRACE_ONLY" = "off" ] && \
  pkgutil --forget io.docker.pkg.docker
[ "$TRACE_ONLY" = "off" ] && \
  pkgutil --forget io.docker.pkg.dockercompose
[ "$TRACE_ONLY" = "off" ] && \
  pkgutil --forget io.docker.pkg.dockermachine
[ "$TRACE_ONLY" = "off" ] && \
  pkgutil --forget io.boot2dockeriso.pkg.boot2dockeriso
 
echo "# Remove virtual Box"
delete_folder "/Applications/VirtualBox.app"
for i in $(ls "/Users/"); do
{
  delete_folder "/Users/$i/Library/VirtualBox"
  delete_file "/Users/$i/Library/Preferences/org.VirtualBox.app.VirtualBox.plist"
  delete_folder "/Users/$i/Library/Saved Application State/org.VirtualBox.app.VirtualBox.SavedState"
  delete_file "/Users/$i/Library/LaunchAgents/org.virtualbox.vboxwebsrv.plist"
  delete_folder "/Users/$i/Library/Saved Application State/org.VirtualBox.app.VirtualBox.SavedState"
} done;
