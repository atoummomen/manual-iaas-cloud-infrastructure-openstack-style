tgtadm --lld iscsi --mode target --op new --tid=1 --targetname iqn.2009-02.com.example:for.all
tgtadm --lld iscsi --mode target --op bind --tid 1 -I ALL
