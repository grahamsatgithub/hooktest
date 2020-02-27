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

sudo mkdir /mnt/peith7teashoo7ab
if [ ! -d "/etc/smbcredentials" ]; then
sudo mkdir /etc/smbcredentials
fi
if [ ! -f "/etc/smbcredentials/peith7teashoo7ab.cred" ]; then
    sudo bash -c 'echo "username=peith7teashoo7ab" >> /etc/smbcredentials/peith7teashoo7ab.cred'
    sudo bash -c 'echo "password=3eQgk6CuzLlTKyyyeeb/UWuBj5TdoIdEkJ7L4lNImb2sn9++Blf/WAQc4JpNZoynJYZt6C4EjfQ4uvAFZMdBkA==" >> /etc/smbcredentials/peith7teashoo7ab.cred'
fi
sudo chmod 600 /etc/smbcredentials/peith7teashoo7ab.cred

sudo bash -c 'echo "//peith7teashoo7ab.file.core.windows.net/pipeline /mnt/peith7teashoo7ab cifs nofail,vers=3.0,credentials=/etc/smbcredentials/peith7teashoo7ab.cred,dir_mode=0777,file_mode=0777,serverino" >> /etc/fstab'
sudo mount -t cifs //peith7teashoo7ab.file.core.windows.net/pipeline /mnt/peith7teashoo7ab -o vers=3.0,credentials=/etc/smbcredentials/peith7teashoo7ab.cred,dir_mode=0777,file_mode=0777,serverino

docker run -i \
    -v "$PWD:$hostmount" \
    -v "/mnt/peith7teashoo7ab:$hostshare" \
    --entrypoint="$hostmount/$entrypoint" \
    "$container"
