#!/usr/bin/env bash

# compute1 br-tun flow reload
# VLAN 50 -> VNI 100
# VLAN 60 -> VNI 200
# VLAN 70 -> VNI 300

ovs-ofctl del-flows br-tun
ovs-ofctl add-flow br-tun priority=0,actions=drop

# From br-int to VXLAN
ovs-ofctl add-flow br-tun priority=10,in_port='patch-int',dl_vlan=50,actions='set_field:0x64->tun_id',strip_vlan,NORMAL
ovs-ofctl add-flow br-tun priority=10,in_port='patch-int',dl_vlan=60,actions='set_field:0xC8->tun_id',strip_vlan,NORMAL
ovs-ofctl add-flow br-tun priority=10,in_port='patch-int',dl_vlan=70,actions='set_field:0x12C->tun_id',strip_vlan,NORMAL

# From VXLAN to br-int with autolearning

# VLAN 50 / VNI 100
ovs-ofctl add-flow br-tun priority=10,in_port='vxlan12',tun_id=0x64,actions="mod_vlan_vid:50,learn(table=0,hard_timeout=300,priority=11,cookie=0x1,NXM_OF_VLAN_TCI[0..11],NXM_OF_ETH_DST[]=NXM_OF_ETH_SRC[],load:0->NXM_OF_VLAN_TCI[],load:NXM_NX_TUN_ID[]->NXM_NX_TUN_ID[],output:OXM_OF_IN_PORT[]),output:patch-int"
ovs-ofctl add-flow br-tun priority=10,in_port='vxlan1n',tun_id=0x64,actions="mod_vlan_vid:50,learn(table=0,hard_timeout=300,priority=11,cookie=0x1,NXM_OF_VLAN_TCI[0..11],NXM_OF_ETH_DST[]=NXM_OF_ETH_SRC[],load:0->NXM_OF_VLAN_TCI[],load:NXM_NX_TUN_ID[]->NXM_NX_TUN_ID[],output:OXM_OF_IN_PORT[]),output:patch-int"
ovs-ofctl add-flow br-tun priority=10,in_port='vxlan13',tun_id=0x64,actions="mod_vlan_vid:50,learn(table=0,hard_timeout=300,priority=11,cookie=0x1,NXM_OF_VLAN_TCI[0..11],NXM_OF_ETH_DST[]=NXM_OF_ETH_SRC[],load:0->NXM_OF_VLAN_TCI[],load:NXM_NX_TUN_ID[]->NXM_NX_TUN_ID[],output:OXM_OF_IN_PORT[]),output:patch-int"

# VLAN 60 / VNI 200
ovs-ofctl add-flow br-tun priority=10,in_port='vxlan12',tun_id=0xC8,actions="mod_vlan_vid:60,learn(table=0,hard_timeout=300,priority=11,cookie=0x1,NXM_OF_VLAN_TCI[0..11],NXM_OF_ETH_DST[]=NXM_OF_ETH_SRC[],load:0->NXM_OF_VLAN_TCI[],load:NXM_NX_TUN_ID[]->NXM_NX_TUN_ID[],output:OXM_OF_IN_PORT[]),output:patch-int"
ovs-ofctl add-flow br-tun priority=10,in_port='vxlan1n',tun_id=0xC8,actions="mod_vlan_vid:60,learn(table=0,hard_timeout=300,priority=11,cookie=0x1,NXM_OF_VLAN_TCI[0..11],NXM_OF_ETH_DST[]=NXM_OF_ETH_SRC[],load:0->NXM_OF_VLAN_TCI[],load:NXM_NX_TUN_ID[]->NXM_NX_TUN_ID[],output:OXM_OF_IN_PORT[]),output:patch-int"
ovs-ofctl add-flow br-tun priority=10,in_port='vxlan13',tun_id=0xC8,actions="mod_vlan_vid:60,learn(table=0,hard_timeout=300,priority=11,cookie=0x1,NXM_OF_VLAN_TCI[0..11],NXM_OF_ETH_DST[]=NXM_OF_ETH_SRC[],load:0->NXM_OF_VLAN_TCI[],load:NXM_NX_TUN_ID[]->NXM_NX_TUN_ID[],output:OXM_OF_IN_PORT[]),output:patch-int"

# VLAN 70 / VNI 300
ovs-ofctl add-flow br-tun priority=10,in_port='vxlan12',tun_id=0x12C,actions="mod_vlan_vid:70,learn(table=0,hard_timeout=300,priority=11,cookie=0x1,NXM_OF_VLAN_TCI[0..11],NXM_OF_ETH_DST[]=NXM_OF_ETH_SRC[],load:0->NXM_OF_VLAN_TCI[],load:NXM_NX_TUN_ID[]->NXM_NX_TUN_ID[],output:OXM_OF_IN_PORT[]),output:patch-int"
ovs-ofctl add-flow br-tun priority=10,in_port='vxlan1n',tun_id=0x12C,actions="mod_vlan_vid:70,learn(table=0,hard_timeout=300,priority=11,cookie=0x1,NXM_OF_VLAN_TCI[0..11],NXM_OF_ETH_DST[]=NXM_OF_ETH_SRC[],load:0->NXM_OF_VLAN_TCI[],load:NXM_NX_TUN_ID[]->NXM_NX_TUN_ID[],output:OXM_OF_IN_PORT[]),output:patch-int"
ovs-ofctl add-flow br-tun priority=10,in_port='vxlan13',tun_id=0x12C,actions="mod_vlan_vid:70,learn(table=0,hard_timeout=300,priority=11,cookie=0x1,NXM_OF_VLAN_TCI[0..11],NXM_OF_ETH_DST[]=NXM_OF_ETH_SRC[],load:0->NXM_OF_VLAN_TCI[],load:NXM_NX_TUN_ID[]->NXM_NX_TUN_ID[],output:OXM_OF_IN_PORT[]),output:patch-int"