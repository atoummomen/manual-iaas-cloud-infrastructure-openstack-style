LUN_ID=$1
LUN_DEV=$2
# iscsi-target-lun-add.sh 1 /dev/cinder-volumes/tc1red-lvm
tgtadm --lld iscsi --mode logicalunit --op new --tid 1 --lun $LUN_ID -b $LUN_DEV

