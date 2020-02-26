#!/bin/bash

configuration="$1"

echo "configuration=$configuration"

. "$configuration"

echo "entrypoint=$entrypoint"
echo "container=$container"
echo "hostmount=$hostmount"

[[ -z "$configuration" ]] && exit
[[ -z "$entrypoint" ]] && exit
[[ -z "$container" ]] && exit
[[ -z "$hostmount" ]] && exit

docker run -i \
    -v "$PWD:$hostmount" \
    --entrypoint="$hostmount/$entrypoint" \
    "$container"
