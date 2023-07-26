#!/bin/sh

read -p "請輸入版本: " VERSION
directory=$(find /Users/mac5/Documents/gen_app -type d -name "*$VERSION*" | head -n 1 )

# 检查是否找到目录
if [ -z "$VERSION" ]; then
    echo "not found"
else
    # 搜索包含特定字符串的目录
    directory=$(find /Users/mac5/Documents/gen_app -type d -name "*$VERSION*" | head -n 1)
    # 检查是否找到目录
    if [ -z "$directory" ]; then
        echo "not found"
    else
        # 将找到的目录赋值给变量
        myvar="$directory"
        foldername=$(basename $myvar)
        echo $myvar
        echo $foldername
    fi
fi


./test2.sh $VERSION