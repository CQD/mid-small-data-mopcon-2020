#!/bin/bash

# 沒有範例資料檔的話，產生之
if [ ! -f example2_log/20200901.gz ] ; then
    source prepare_data2.sh
fi

echo === 偷看資料 ===
gunzip -c example2_log/*.gz | head -n 3

echo
echo === 計算行數 ===
gunzip -c example2_log/*.gz | wc -l

echo
echo === 計算總使用排行 ===
gunzip -c example2_log/*.gz | awk -f example2_1.awk | sort -k2 -nr | head -n 10

echo
echo === 計算包含特定標籤的項目的排行 ===
gunzip -c example2_log/*.gz | awk -f example2_2.awk | sort -k2 -nr | head -n 10

echo
