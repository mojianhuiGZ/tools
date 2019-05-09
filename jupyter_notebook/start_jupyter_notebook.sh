#!/bin/bash
local_ip=`ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | awk -F"/" '{print $1}'`
#jt -t solarizedd -f fira -fs 13 -nf fira -nfs 13 -tf fira -tfs 13 -ofs 13 -dfs 11 -T
jt -t solarizedl -f fira -fs 13 -nf fira -nfs 13 -tf fira -tfs 13 -ofs 13 -dfs 11 -T
echo '注意将jupyter notebook的IP地址替换为外网地址'
jupyter notebook --no-browser --allow-root --ip=$local_ip --port=8000
