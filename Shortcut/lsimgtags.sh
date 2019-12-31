#!/bin/sh
# list docker images tags

repo_url=https://registry.hub.docker.com/v1/repositories
image_name=$1

# mac 上需要安装jq: brew install jq
curl -s ${repo_url}/${image_name}/tags | jq | grep name | awk '{print $2}' | sed -e 's/"//g'
