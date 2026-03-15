# Floating IP Layer

This module documents the manual Floating IP mechanism implemented in the manual-iaas-cloud-infrastructure-openstack-style infrastructure.

The implementation is performed entirely on the netnode inside the router namespace (`qr-vnet`) and reproduces the fundamental behavior of a cloud Floating IP service without relying on OpenStack.

---

## Concept

A Floating IP provides external reachability to a virtual machine located inside a private tenant subnet.

This is achieved by:

- Assigning a public (external) IP address to the router’s external interface (`qg-tap`)
- Applying a DNAT rule (external → internal)
- Applying a SNAT rule (internal → external)

This enables:

External Client ↔ Floating IP ↔ Router Namespace ↔ Private VM

---

## Components

Router namespace:
- `qr-vnet`

External router interface:
- `qg-tap`

External subnet:
- `192.168.96.0/24`

Internal tenant subnets:
- `192.168.0.0/24`
- `192.168.1.0/24`
- `192.168.2.0/24`

---

## Scripts

- `add-floating.sh`
- `del-floating.sh`

These scripts manipulate IP addressing and NAT rules inside the router namespace using:

- `iproute2`
- `iptables`

---

## Operational Model

When adding a Floating IP:

1. The external IP is assigned to `qg-tap`
2. A SNAT rule maps VM private IP → Floating IP
3. A DNAT rule maps Floating IP → VM private IP

When removing a Floating IP:

- The IP address is removed
- SNAT rule is deleted
- DNAT rule is deleted

---

## Scope and Limitations

- The private VM address must belong to a defined tenant subnet
- The Floating IP must belong to the external network attached to `qg-tap`
- Rules are applied manually; there is no orchestration layer
- Rule ordering in the NAT table matters

This module represents the manual service-plane implementation of external connectivity within the IaaS architecture.
