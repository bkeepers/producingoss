#!/bin/sh

# See http://stackoverflow.com/questions/2116718/\
# svn-error-cant-convert-string-from-native-encoding-to-utf-8
# for more.  Summary: Hooks are run in a vacuum environment.
LC_CTYPE=en_US.UTF-8
export LC_CTYPE

cd /www/producingoss

SVN=/usr/bin/svn
NICE=/usr/bin/nice
MAKE=/usr/bin/make

${SVN} update
${NICE} ${MAKE} www
