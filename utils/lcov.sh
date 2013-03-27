#!/bin/bash
#set -x

DIRS=`/bin/ls files-* -d`
CMD_OPT=""
KERN_DIR="ns-3-linux"
KERN_DIR="net-next-sim"
APP_SRC_DIR=$1
DCE_DIR=`pwd`
HTML_DIR=lcov-report

cd ${APP_SRC_DIR}
APP_SRC_DIR=`pwd`
cd ${DCE_DIR}


for node in ${DIRS}
do

#gcov *.gcda
find $1 -name "*.gcno" | cpio -pud ${node}/${APP_SRC_DIR} > /dev/null
../ns-3-dev/utils/lcov/lcov -q -c -d ${node}${APP_SRC_DIR} -b ${APP_SRC_DIR} -o dce-run-${node}.info 
CMD_OPT="$CMD_OPT"" -a dce-run-${node}.info"

done

../ns-3-dev/utils/lcov/lcov -q ${CMD_OPT} -o dce-run.info
../ns-3-dev/utils/lcov/genhtml -q --legend -o ${HTML_DIR} dce-run.info > /dev/null

rm -f dce-run-files-*.info
rm -f dce-run.info