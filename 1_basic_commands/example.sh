#!/bin/bash

# 沒有範例資料檔的話，產生之
if [ ! -f data.gz ] ; then
    source ./prepare_data.sh
fi

echo === 偷看資料 ===
gunzip -c data.gz | head

echo
echo === 計算行數 ===
gunzip -c data.gz | wc -l

echo
echo === 檔案內有幾個不同的數字 ===
gunzip -c data.gz | sort -u | wc -l

echo
echo === 計算數字出現的次數（節錄） ===
gunzip -c data.gz | sort | uniq -c | head

echo
echo === 把數字依照出現次數排序（節錄） ===
gunzip -c data.gz | sort | uniq -c | sort -n -r | head

echo
echo === 數字出現次數的分佈狀況 ===
gunzip -c data.gz | sort | uniq -c | sort -n -r | awk '{print $1}' | uniq -c

echo
