# iSCSI Target (Netnode)

This directory documents the netnode-side iSCSI target configuration.

The netnode exports LVM Logical Volumes as iSCSI LUNs to compute nodes.

---

## Role

The target is responsible for:

- Creating the global iSCSI target
- Binding initiator access
- Exporting each Logical Volume as a unique LUN

---

## Example Target

Target name:

`iqn.2009-02.com.example:for.all`

---

## LUN Export Example

- LUN 1 → `/dev/cinder-volumes/tc1red-lvm`
- LUN 2 → `/dev/cinder-volumes/tc1blue-lvm`
- LUN 3 → `/dev/cinder-volumes/tc1green-lvm`

LUN IDs must remain unique and consistent across the environment.

---

## Scope Boundary

This layer does not create Logical Volumes.

It only exports existing LVs through iSCSI.
