#!/bin/bash

echo "產生範例資料檔案，會需要跑個幾分鐘"
echo "資料格式為: id、逗點分隔標籤、次數"

dir="example2_log"

if [ ! -d "$dir" ]; then
    mkdir "$dir"
fi

for ymd in $(seq -f "%.0f" 20200901 20200931); do
    echo 處理 "$dir"/"$ymd"
    ../bin/rand 100000 2 | awk '
        {
            srand($1);
            tagcnt = rand() * 100 % 4;
            tags_str = int(rand() * 100 % 10);
            for (;tagcnt > 0; tagcnt--) {
                tags_str =  tags_str","int(rand() * 100 % 10)
            }
            print $1, tags_str, $2
        }' | gzip > "$dir"/"$ymd".gz
done;

echo 完成
