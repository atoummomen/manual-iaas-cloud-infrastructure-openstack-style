# Live Migration – Ephemeral Storage

## Scenario

VM: tc1red  
Source: compute1  
Destination: compute2  
Disk type: local ephemeral image file

---

## Migration Steps

# Step 1 – Start VM on source node
virsh start tc1red --console

# (Optional) Generate traffic inside VM
ping 8.8.8.8

# Detach console while keeping VM running

# Step 2 – Perform live migration
virsh migrate --live --copy-storage-all --persistent --undefinesource --verbose tc1red qemu+ssh://192.168.56.102/system

---

## Notes

- --copy-storage-all is required for local disks.
- Migration transfers execution state and storage.
