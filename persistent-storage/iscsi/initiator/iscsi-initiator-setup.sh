iscsiadm  -m discovery -t st -p 192.168.56.100
iscsiadm --mode node --targetname "iqn.2009-02.com.example:for.all" --portal 192.168.56.100 --login
