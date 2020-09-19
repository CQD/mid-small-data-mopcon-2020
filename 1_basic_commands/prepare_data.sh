#!/bin/bash

size=200000

echo "產生 $size 行 0 ~ 32767 的隨機數字，寫進 data.gz..."
../bin/rand "$size" | gzip > data.gz
echo "完成"
