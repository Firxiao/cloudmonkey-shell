#!/bin/bash - 
#===============================================================================
#
#          FILE: stop_all_vm.sh
# 
#         USAGE: ./stop_all_vm.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Firxiao (), 
#  ORGANIZATION: 
#       CREATED: 12/13/15 14:17
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
BIN=`which cloudmonkey`

$BIN list virtualmachines filter=id|grep id|awk '{print $3}' > /tmp/id.temp

while read line
do
$BIN stop virtualmachine id=$line &
done < /tmp/id.temp


