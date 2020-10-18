#!/bin/bash

# 注意：實價登錄資料延遲登錄的狀況相當嚴重
# 單季份紀錄算出來的參考價值十分有限
# 認真想看的話請拉更長時間的紀錄，然後分交易時間來分析

if ! command -v jq > /dev/null
then
    echo 尚未安裝 jq
    echo 可透過 brew（Mac） / apt（Ubuntu）安裝
    echo 或到官網（https://stedolan.github.io/jq/）下載最新版執行檔
    exit -1
fi

echo === 偷看資料 ===
gunzip -c kh_realprice_109S3.json.gz | head -n 1 | jq '.'

echo
echo === 計算行數 ===
gunzip -c kh_realprice_109S3.json.gz | wc -l

echo
echo === 計算車位類別數 ===
gunzip -c kh_realprice_109S3.json.gz | jq -r '.["車位類別"]' | sort | uniq -c

echo
echo === 高雄市的成交價與坪數（節錄） ===
gunzip -c kh_realprice_109S3.json.gz \
    | jq -r -c '[ .["總價元"], (.["建物移轉總面積平方公尺"]|tonumber) * 0.3025 ]' \
    | head -n 2

echo
echo === 鼓山區的成交價與坪數（節錄） ===
gunzip -c kh_realprice_109S3.json.gz \
    | jq -r -c 'select(.["鄉鎮市區"] == "鼓山區") | [ .["總價元"], (.["建物移轉總面積平方公尺"]|tonumber) * 0.3025 ] | @csv' \
    | head -n 2

echo
echo === 鼓山區的平均成交單價，依大小群組分列 ===
echo ' (注意：未考慮車位價格與年份)'
gunzip -c kh_realprice_109S3.json.gz \
    | jq -r -c 'select(.["鄉鎮市區"] == "鼓山區") | [ (.["總價元"]|tonumber) , (.["建物移轉總面積平方公尺"]|tonumber) * 0.3025 ] | select(.[1] > 10) | @csv' \
    | awk -F ',' '
{
    price = $1;
    size = $2;

    unitprice = price / size;
    sizegroup = int(size / 10) * 10;

    sum[sizegroup] += unitprice;
    cnt[sizegroup]++
}

END {
    for (sizegroup in sum) {
        printf "%4d | 單價:%7d, 交易數: %4d\n",sizegroup, sum[sizegroup]/cnt[sizegroup], cnt[sizegroup]
    }
}'

