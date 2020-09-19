#!/bin/bash

echo "撈取範例 apache log 檔案，存進 data.gz..."

curl -# 'https://raw.githubusercontent.com/elastic/examples/master/Common%20Data%20Formats/apache_logs/apache_logs' \
    | gzip > data.gz

echo 完成
