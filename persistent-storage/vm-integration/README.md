# VM Integration

This directory documents how an iSCSI-exported Logical Volume is attached to a virtual machine using libvirt.

At this stage:

- The Logical Volume exists on the netnode
- The LV is exported as an iSCSI LUN
- The compute node has logged in to the iSCSI target
- The remote block device appears under /dev/disk/by-path/

The final step is defining a VM that uses this block device directly.

---

## Role

This layer connects persistent storage to the virtual machine definition.

The VM does not use a qcow2 image file.

Instead, libvirt uses a raw block device exposed by the iSCSI initiator.

---

## Integration Workflow

1. Dump the XML of an existing VM
2. Create a new VM definition for the LVM-backed version
3. Change the disk type from file to block
4. Update the <source dev='...'> to the correct iSCSI by-path device
5. Regenerate UUID and MAC address
6. Define and start the VM

---

## Example Disk Section

<disk type='block' device='disk'>
  <driver name='qemu' type='raw' cache='none' io='native'/>
  <source dev='/dev/disk/by-path/ip-192.168.56.100:3260-iscsi-iqn.2009-02.com.example:for.all-lun-2'/>
  <target dev='vda' bus='virtio'/>
</disk>

This configuration allows the VM to boot directly from a remote LVM-backed disk.
