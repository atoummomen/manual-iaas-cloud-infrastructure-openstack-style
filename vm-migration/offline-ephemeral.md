# Offline Migration – Ephemeral Storage

## Scenario

VM: `tc1red`  
Source: `compute1`  
Destination: `compute2`  
Disk type: Local ephemeral image file

---

## Migration Steps

### Step 1 – Dump VM XML on source node

```bash
virsh dumpxml tc1red > tc1red.xml