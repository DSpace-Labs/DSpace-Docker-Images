#!/bin/sh
OS=`uname -o`
DSPACE_INSTALL=/dspace
CMDPFX="";
if [ "$OS" == "Msys" ]
then
  DSPACE_INSTALL=//dspace
  CMDPFX="winpty "
fi
