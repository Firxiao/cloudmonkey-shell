#!/bin/bash - 
#===============================================================================
#
#          FILE: checkcloud.sh
# 
#         USAGE: ./checkcloud.sh 
# 
#   DESCRIPTION: count vm in cs or check vm and ip
# 
#       OPTIONS: -s -f -l
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Firxiao (), 
#  ORGANIZATION: 
#       CREATED: 2015/01/19 14:29
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error



function count_all_vm() {
cloudmonkey list virtualmachines  details=stats |grep "^count"
}

function count_all_up_vm() {
cloudmonkey list virtualmachines state=Running details=stats |grep "^count"
}

function count_all_down_vm() {
cloudmonkey list virtualmachines state=Stopped details=stats |grep "^count"
}


function vm_ip() {
cloudmonkey list virtualmachines  details=stats,nics filter=name,displayname,ipaddress
}

function count() {
case $OPTARG in
	all_vm)
		echo "check :$OPTARG";
		count_all_vm;
		;;
	all_vm_up)
		echo "check :$OPTARG";
		count_all_up_vm;
		;;
	all_vm_down)
		echo "check :$OPTARG";
		count_all_down_vm;
		;;
		*)
		echo "Useage: `basename $0` -c all_vm | all_vm_up | all_vm_down"
		exit 1 
		;;
esac

}

function list() {
case $OPTARG in
	vm_ip)
		echo "check :$OPTARG";
		vm_ip;
		;;
	*)
		echo "Useage: `basename $0` -l vm_ip"
esac
}



function select_id() {
cloudmonkey list virtualmachines details=stats,nics $OPTARG filter=name,displayname,ipaddress
}

function select_id_from_name() {
echo $OPTARG\'s ID is `cloudmonkey list virtualmachines details=stats  $OPTARG filter=id`
}


if [ $# = 0 ]
then

echo "Useage: `basename $0` -c  all_vm | all_vm_up | all_vm_down \n \
	           -l  vm_ip \n \
	           -s  \"id=xxxxxx\"|\"name=xxx\" 
	           -n  \"name=xxxxxx\" "
			exit 1 
fi

while getopts "c:l:s:n:" arg
do
	case $arg in
		c)
			count
			;;
		l) 
			list
			;;
		s)
			select_id
			;;
		n)
			select_id_from_name
			;;
		?)
		echo "Useage: `basename $0` -c  all_vm | all_vm_up | all_vm_down \n \
	           -l  vm_ip \n \
	           -s  \"id=xxxxxx\" 
	           -n  \"name=xxxxxx\" "
			exit 1 
			;;
	esac
done
