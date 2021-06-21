# AWS Developer: Building on AWS on edX

After launching an ec2 instance, you can view the log file using the command below

```bash
$ curl http://169.254.169.254/latest/meta-data/
[ec2-user@ip-172-31-1-21 ~]$ curl http://169.254.169.254/latest/meta-data/
ami-id
ami-launch-index
ami-manifest-path
block-device-mapping/
events/
hibernation/
hostname
identity-credentials/
instance-action
instance-id
instance-life-cycle
instance-type
local-hostname
local-ipv4
mac
metrics/
network/
placement/
profile
public-hostname
public-ipv4
public-keys/
reservation-id
security-groups
```

## Useful commands

> To view the log file, type the command below in your instance terminal.

    cat /var/log/cloud-init-output.log

> Explore the log file to see the log entries generated for installing the user data script. To view the instance metadata, type the command below:

    [ec2-user@ip-172-31-1-21 ~]$ curl http://169.254.169.254/latest/meta-data/
    ami-id
    ami-launch-index
    ami-manifest-path
    block-device-mapping/
    events/
    hibernation/
    hostname
    identity-credentials/
    instance-action
    instance-id
    instance-life-cycle
    instance-type
    local-hostname
    local-ipv4
    mac
    metrics/
    network/
    placement/
    profile
    public-hostname
    public-ipv4
    public-keys/
    reservation-id
    security-groups

> Execute the command below to get the instance identity document of your instance:

    curl http://169.254.169.254/latest/dynamic/instance-identity/document

> Execute the command below to get the instance public IP address:

    curl http://169.254.169.254/latest/meta-data/public-ipv4

> Execute the command below to get the MAC address of the instance:

    curl http://169.254.169.254/latest/meta-data/mac

> Execute the command below to get the VPC ID in which the instance resides. Make sure to replace Your-MAC in the command below with the MAC address of your instance:

    curl http://169.254.169.254/latest/meta-data/network/interfaces/macs/Your-MAC/vpc-id

> Execute the command below to get the subnet-id in which the instance resides. Make sure to replace Your-MAC in the command below with the MAC address of your instance:

    curl http://169.254.169.254/latest/meta-data/network/interfaces/macs/Your-MAC/subnet-id

> Execute the command below to get the instance user data:

    curl http://169.254.169.254/latest/user-data
