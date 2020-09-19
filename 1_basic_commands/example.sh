#!/bin/bash

# 沒有範例資料檔的話，產生之
if [ ! -f data.gz ] ; then
    source ./prepare_data.sh
fi

echo === 偷看資料 ===
zcat < data.gz | head

echo
echo === 計算行數 ===
zcat < data.gz | wc -l

echo
echo === 檔案內有幾個不同的數字 ===
zcat < data.gz | sort -u | wc -l

echo
echo === 計算數字出現的次數（節錄） ===
zcat < data.gz | sort | uniq -c | head

echo
echo === 把數字依照出現次數排序（節錄） ===
zcat < data.gz | sort | uniq -c | sort -n -r | head

echo
echo === 數字出現次數的分佈狀況 ===
zcat < data.gz | sort | uniq -c | sort -n -r | awk '{print $1}' | uniq -c

echo
