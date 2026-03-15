# Offline Migration – Ephemeral Storage

## Scenario

VM: tc1red  
Source: compute1  
Destination: compute2  
Disk type: local ephemeral image file

---

## Migration Steps

# Step 1 – Dump VM XML on source node
virsh dumpxml tc1red > tc1red.xml

# Step 2 – Copy XML to destination node
scp tc1red.xml 192.168.56.102:~

# Step 3 – Copy VM disk image
scp images/tc1red.img 192.168.56.102:~/images/

# Step 4 – Define and start VM on destination node
virsh define tc1red.xml
virsh start tc1red

---

## Notes

- Both XML and disk must be copied.
- Required because storage is local to compute1.
