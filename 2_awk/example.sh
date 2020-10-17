#!/bin/bash

# 沒有範例資料檔的話，產生之
if [ ! -f data.gz ] ; then
    source prepare_data.sh
fi

echo === 偷看資料 ===
gunzip -c data.gz | head -n 3

echo
echo === 計算行數 ===
gunzip -c data.gz | wc -l

echo
echo === 印出 response 大小超過 100k 的 url ===
gunzip -c data.gz | awk '$10>100000{print $7}' | sort -u | head -n 3

echo
echo === 拉出存取量最多的 IP，然後看他在做什麼（節錄） ===
gunzip -c data.gz \
    | awk '{cnt[$1]++} END{for(ip in cnt){print ip, cnt[ip]}}' \
    | sort -k2 -n -r \
    | head -n 2 \

gunzip -c data.gz | awk '$1=="66.249.73.135" {print $4, $7} ' | head

echo
echo === blog tag 觀看排行榜 ===

gunzip -c data.gz \
    | awk '$7 ~ /\/blog\/tags/{print $7}' \
    | sort \
    | uniq -c \
    | awk '{print $2, $1}' \
    | sort -k2 -n -r \
    | head -n 5

echo
echo === /blog/ 的每小時存取量（節錄） ===

gunzip -c data.gz \
    | awk '$7 ~ /\/blog/{print substr($4, 2, 15)"00"}' \
    | uniq -c \
    | awk '{print $2, $1}' | head -n 5



echo
