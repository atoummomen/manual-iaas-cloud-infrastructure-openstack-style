# iSCSI Initiator (Compute Nodes)

This directory documents the compute-side iSCSI initiator configuration.

Compute nodes connect to the iSCSI target running on the netnode and expose exported LUNs as local block devices.

---

## Role

The initiator is responsible for:

- Discovering the iSCSI target
- Logging in to the target
- Exposing remote LUNs under `/dev/disk/by-path/`

---

## Example Target

Target portal:
`192.168.56.100`

Target name:
`iqn.2009-02.com.example:for.all`

---

## Result

After successful login, the exported LUN appears as:

`/dev/disk/by-path/ip-192.168.56.100:3260-iscsi-iqn.2009-02.com.example:for.all-lun-X`

This device can then be referenced directly in the libvirt VM XML as a raw block disk.

---

## Scope

This layer does not create storage.

It only attaches already exported LUNs from the netnode.
