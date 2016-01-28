Some ISPs change the IP address frequently,
others provide it on a long lease but may still change it.
Most ISPs allocate their range of IP addresses dynamically (using DHCP),
and the “lease” is often set to 24 hours,
which is why your address might change frequently.
For most users changing IP doesn’t matter,
but in my case, I need a known address so I can login.
If you need to have a fixed address,
you can ask your ISP for static address,
but if  they offer this service at all, they will charge you for it.

I don't want to pay for the static IP address, so I need an alternative.
One alternative is to make use of a Dynamic DNS address service.
These services associate your actual address (in its numerical form)
with a fixed mnemonic address (e.g. http://www.noip.com/) in real time,
so as long as you have  mnemonic form,
it will point you to  your server.
This service can also cost you money.

The cheapskate alternative is to create a service on your server
that email updates to you when the IP address changes.
This is practical if the IP address isn't changing too frequently,
which happens to be my case.
My choose is to use a  simple service for periodically looking up my IP address,
specifically the website  http://ifconfig.co.
The design is to execute the command `curl ifconfig.co` periodically,
check if the IP address has changes, and if so, email or text the change to myself.
I place this shell program in cron:

```bash
#!/bin/bash

# This utility is used to periodically check to see if the external IP address
# has changed, and if so, send a notification giving the new IP address.

IP_ADDRESS_STORE=$HOME/.external_ip_address
CURRENT_IP=$(cat $IP_ADDRESS_STORE)
NEW_IP=$(curl ifconfig.co)

if [ $CURRENT_IP -eq $NEW_IP ];
    then
        apprase -t "External IP Address" -m "No change in external IP address"
        exit 0
    else
        echo $NEW_IP > $IP_ADDRESS_STORE
        apprase -t "External IP Address" -m "External IP address has changed from $CURRENT_IP to $NEW_IP"
        exit 0
fi

# Parse command line options
USAGE="Usage: `basename $0` [-h] -t title -m message"
while getopts ht:m: OPT; do
    case "$OPT" in
        h)
            echo $USAGE
            exit 0
            ;;
        t)
            TITLE=$OPTARG
            ;;
        m)
            MESSAGE=$OPTARG
            ;;
        \?)
            # getopts issues an error message
            echo $USAGE >&2
            exit 1
            ;;
    esac
done

```


