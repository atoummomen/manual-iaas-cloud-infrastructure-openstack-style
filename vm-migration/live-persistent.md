# Live Migration – Persistent Storage

## Scenario

VM: tc1red-lv  
Source: compute1  
Destination: compute2  
Disk type: remote iSCSI LUN

---

## Migration Steps

# Step 1 – Start VM on source node
virsh start tc1red-lv --console

# (Optional) Generate traffic inside VM
ping 8.8.8.8

# Detach console while keeping VM running

# Step 2 – Perform live migration
virsh migrate --live --persistent --undefinesource --verbose tc1red-lv qemu+ssh://192.168.56.102/system

---

## Notes

- No storage copy required.
- Only VM runtime state is transferred.
- Disk remains on netnode.
