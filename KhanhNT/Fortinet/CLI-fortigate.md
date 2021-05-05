https://docs.fortinet.com/document/fortigate/6.4.4/administration-guide/256518/configuring-sd-wan-in-the-cli

FortiGate-VM64-KVM (sdwan) # show members 
config members
    edit 1
        set interface "port2"
    next
    edit 2
        set interface "port3"
    next
end

FortiGate-VM64-KVM (interface) # get port1

https://docs.fortinet.com/vm/xen/fortigate/6.2/xen-cookbook/6.2.0/615472/configuring-port-1
