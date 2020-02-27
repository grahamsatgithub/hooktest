#!/bin/bash

configuration="$1"
cifsusername="$2"
cifspassword="$3"

echo "configuration=$configuration"
echo "cifsusername=$cifsusername"
echo "cifspassword=$cifspassword"

. "$configuration"

echo "entrypoint=$entrypoint"
echo "container=$container"
echo "hostmount=$hostmount"
echo "hostshare=$hostshare"

[[ -z "$configuration" ]] && exit 1
[[ -z "$entrypoint" ]] && exit 1
[[ -z "$container" ]] && exit 1
[[ -z "$hostmount" ]] && exit 1
[[ -z "$hostshare" ]] && exit 1
[[ -z "$cifsusername" ]] && exit 1
[[ -z "$cifspassword" ]] && exit 1

cifsconfig="/etc/smbcredentials"
cifscred="peith7teashoo7ab.cred"

cifsshare="//peith7teashoo7ab.file.core.windows.net/pipeline"
cifsmount="/mnt/peith7teashoo7ab"
cifsoptions="vers=3.0,credentials=$cifsconfig/$cifscred,dir_mode=0777,file_mode=0777,serverino"

sudo mkdir -vp "$cifsmount"
sudo mkdir -vp "$cifsconfig"

sudo mv -v "$cifscred" "$cifsconfig/$cifscred"

sudo chown -v root:root "$cifsconfig/$cifscred"
sudo chmod -v 600 "$cifsconfig/$cifscred"

sudo mount -vt cifs "$cifsshare" "$cifsmount" -o "$cifsoptions" || exit 1

docker run -i \
    -v "$PWD:$hostmount" \
    -v "$cifsmount:$hostshare" \
    --entrypoint="$hostmount/$entrypoint" \
    "$container"
