#!/bin/sh
YOURDOMAIN="example.com"
 
[[ $RENEWED_LINEAGE != "/etc/letsencrypt/live/$YOURDOMAIN" ]] && exit 0
echo "Updating certs"
cat /etc/letsencrypt/live/$YOURDOMAIN/{privkey,fullchain}.pem > /var/lib/znc.pem

