#!/bin/sh

get_source_home() {
    if [[ $1 == "3" ]]; then
        echo "/Users/mac5/Downloads/MOBILE_BANK_APP拷貝"
    elif [[ $1 == "2" ]]; then
        echo "/Users/mac5/Documents/sourcetree/MOBILE_BANK_APP"
    else
        echo "/Users/mac5/Documents/GitHub/MOBILE_BANK_APP"
    fi
}
read -p "請輸入source來源: " arg1
SOURCE_HOME=$(get_source_home $arg1)
echo $SOURCE_HOME

cp -f environment/index.ts $SOURCE_HOME/web_resource/src/app/simulation/api/index.ts

cp -f environment/app-routing.module.ts $SOURCE_HOME/web_resource/src/app/app-routing.module.ts

