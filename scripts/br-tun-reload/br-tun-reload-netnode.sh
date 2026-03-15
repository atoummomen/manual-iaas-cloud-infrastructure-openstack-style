#!/usr/bin/env bash

# netnode br-tun/br-ex flow reload
# VLAN 50 -> VNI 100
# VLAN 60 -> VNI 200
# VLAN 70 -> VNI 300
# External network VLAN: 3

ovs-ofctl del-flows br-tun
ovs-ofctl add-flow br-tun priority=0,actions=drop

# From br-int to VXLAN
ovs-ofctl add-flow br-tun priority=10,in_port='patch-int',dl_vlan=50,actions='set_field:0x64->tun_id',strip_vlan,NORMAL
ovs-ofctl add-flow br-tun priority=10,in_port='patch-int',dl_vlan=60,actions='set_field:0xC8->tun_id',strip_vlan,NORMAL
ovs-ofctl add-flow br-tun priority=10,in_port='patch-int',dl_vlan=70,actions='set_field:0x12C->tun_id',strip_vlan,NORMAL

# From VXLAN to br-int with autolearning

# VLAN 50 / VNI 100
ovs-ofctl add-flow br-tun priority=10,in_port='vxlann1',tun_id=0x64,actions="mod_vlan_vid:50,learn(table=0,hard_timeout=300,priority=11,cookie=0x1,NXM_OF_VLAN_TCI[0..11],NXM_OF_ETH_DST[]=NXM_OF_ETH_SRC[],load:0->NXM_OF_VLAN_TCI[],load:NXM_NX_TUN_ID[]->NXM_NX_TUN_ID[],output:OXM_OF_IN_PORT[]),output:patch-int"
ovs-ofctl add-flow br-tun priority=10,in_port='vxlann2',tun_id=0x64,actions="mod_vlan_vid:50,learn(table=0,hard_timeout=300,priority=11,cookie=0x1,NXM_OF_VLAN_TCI[0..11],NXM_OF_ETH_DST[]=NXM_OF_ETH_SRC[],load:0->NXM_OF_VLAN_TCI[],load:NXM_NX_TUN_ID[]->NXM_NX_TUN_ID[],output:OXM_OF_IN_PORT[]),output:patch-int"
ovs-ofctl add-flow br-tun priority=10,in_port='vxlann3',tun_id=0x64,actions="mod_vlan_vid:50,learn(table=0,hard_timeout=300,priority=11,cookie=0x1,NXM_OF_VLAN_TCI[0..11],NXM_OF_ETH_DST[]=NXM_OF_ETH_SRC[],load:0->NXM_OF_VLAN_TCI[],load:NXM_NX_TUN_ID[]->NXM_NX_TUN_ID[],output:OXM_OF_IN_PORT[]),output:patch-int"

# VLAN 60 / VNI 200
ovs-ofctl add-flow br-tun priority=10,in_port='vxlann1',tun_id=0xC8,actions="mod_vlan_vid:60,learn(table=0,hard_timeout=300,priority=11,cookie=0x1,NXM_OF_VLAN_TCI[0..11],NXM_OF_ETH_DST[]=NXM_OF_ETH_SRC[],load:0->NXM_OF_VLAN_TCI[],load:NXM_NX_TUN_ID[]->NXM_NX_TUN_ID[],output:OXM_OF_IN_PORT[]),output:patch-int"
ovs-ofctl add-flow br-tun priority=10,in_port='vxlann2',tun_id=0xC8,actions="mod_vlan_vid:60,learn(table=0,hard_timeout=300,priority=11,cookie=0x1,NXM_OF_VLAN_TCI[0..11],NXM_OF_ETH_DST[]=NXM_OF_ETH_SRC[],load:0->NXM_OF_VLAN_TCI[],load:NXM_NX_TUN_ID[]->NXM_NX_TUN_ID[],output:OXM_OF_IN_PORT[]),output:patch-int"
ovs-ofctl add-flow br-tun priority=10,in_port='vxlann3',tun_id=0xC8,actions="mod_vlan_vid:60,learn(table=0,hard_timeout=300,priority=11,cookie=0x1,NXM_OF_VLAN_TCI[0..11],NXM_OF_ETH_DST[]=NXM_OF_ETH_SRC[],load:0->NXM_OF_VLAN_TCI[],load:NXM_NX_TUN_ID[]->NXM_NX_TUN_ID[],output:OXM_OF_IN_PORT[]),output:patch-int"

# VLAN 70 / VNI 300
ovs-ofctl add-flow br-tun priority=10,in_port='vxlann1',tun_id=0x12C,actions="mod_vlan_vid:70,learn(table=0,hard_timeout=300,priority=11,cookie=0x1,NXM_OF_VLAN_TCI[0..11],NXM_OF_ETH_DST[]=NXM_OF_ETH_SRC[],load:0->NXM_OF_VLAN_TCI[],load:NXM_NX_TUN_ID[]->NXM_NX_TUN_ID[],output:OXM_OF_IN_PORT[]),output:patch-int"
ovs-ofctl add-flow br-tun priority=10,in_port='vxlann2',tun_id=0x12C,actions="mod_vlan_vid:70,learn(table=0,hard_timeout=300,priority=11,cookie=0x1,NXM_OF_VLAN_TCI[0..11],NXM_OF_ETH_DST[]=NXM_OF_ETH_SRC[],load:0->NXM_OF_VLAN_TCI[],load:NXM_NX_TUN_ID[]->NXM_NX_TUN_ID[],output:OXM_OF_IN_PORT[]),output:patch-int"
ovs-ofctl add-flow br-tun priority=10,in_port='vxlann3',tun_id=0x12C,actions="mod_vlan_vid:70,learn(table=0,hard_timeout=300,priority=11,cookie=0x1,NXM_OF_VLAN_TCI[0..11],NXM_OF_ETH_DST[]=NXM_OF_ETH_SRC[],load:0->NXM_OF_VLAN_TCI[],load:NXM_NX_TUN_ID[]->NXM_NX_TUN_ID[],output:OXM_OF_IN_PORT[]),output:patch-int"

# External traffic handling on br-ex
ovs-ofctl del-flows br-ex
ovs-ofctl add-flow br-ex priority=4,in_port=phy-br-ex,dl_vlan=3,actions=strip_vlan,NORMAL
ovs-ofctl add-flow br-ex priority=2,in_port=phy-br-ex,actions=drop
ovs-ofctl add-flow br-int priority=3,in_port=int-br-ex,vlan_tci=0x0000/0x1fff,actions=mod_vlan_vid:3,NORMAL
ovs-ofctl add-flow br-ex priority=0,actions=NORMAL