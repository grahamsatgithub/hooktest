#!/bin/bash

configuration="$1"

echo "configuration=$configuration"

. "$configuration"

echo "entrypoint=$entrypoint"
echo "container=$container"
echo "hostmount=$hostmount"
echo "hostshare=$hostshare"

[[ -z "$configuration" ]] && exit
[[ -z "$entrypoint" ]] && exit
[[ -z "$container" ]] && exit
[[ -z "$hostmount" ]] && exit
[[ -z "$hostshare" ]] && exit

cifsconfig="/etc/smbcredentials"
cifscred="$cifsconfig/peith7teashoo7ab.cred"

cifsshare="//peith7teashoo7ab.file.core.windows.net/pipeline"
cifsmount="/mnt/peith7teashoo7ab"
cifsoptions="vers=3.0,credentials=$cifscred,dir_mode=0777,file_mode=0777,serverino"

sudo mkdir -vp "$cifsmount"
sudo mkdir -vp "$cifsconfig"

sudo bash -c "echo \"username=peith7teashoo7ab\" > $cifscred"
sudo bash -c "echo \"password=3eQgk6CuzLlTKyyyeeb/UWuBj5TdoIdEkJ7L4lNImb2sn9++Blf/WAQc4JpNZoynJYZt6C4EjfQ4uvAFZMdBkA==\" >> $cifscred"

sudo chmod -v 600 "$cifscred"

sudo bash -c "echo \"$cifsshare $cifsmount cifs nofail,$cifsoptions\" >> /etc/fstab"
sudo mount -vt cifs "$cifsshare" "$cifsmount" -o "$cifsoptions"

docker run -i \
    -v "$PWD:$hostmount" \
    -v "$cifsmount:$hostshare" \
    --entrypoint="$hostmount/$entrypoint" \
    "$container"
