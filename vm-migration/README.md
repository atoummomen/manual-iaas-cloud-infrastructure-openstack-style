# VM Migration Module

This module documents the migration workflows supported in the manual OpenStack-style IaaS infrastructure.

The project covers four migration cases:

- Offline migration with ephemeral storage
- Offline migration with persistent iSCSI-backed storage
- Live migration with ephemeral storage
- Live migration with persistent iSCSI-backed storage

---

## Storage Models

### Ephemeral Storage

- Local disk image stored on the source compute node
- Requires storage transfer during migration

### Persistent Storage (iSCSI + LVM)

- Remote block device hosted on the netnode
- Does not require disk copy during migration
- Only compute-side VM ownership and execution context change

---

## Migration Categories

### Offline Migration

The VM is stopped before migration.

This method is simpler and does not preserve execution continuity.

### Live Migration

The VM remains running during migration.

This method transfers the VM execution state while minimizing service interruption.

---

## Network Requirements

All compute nodes must be able to:

- Reach each other over the management and infrastructure network
- Resolve each other correctly
- Establish SSH-based libvirt migration connectivity

---

## Notes

- SSH access between compute nodes must be enabled
- Libvirt and QEMU migration support must already be operational
- The correct workflow depends on the storage model attached to the VM
