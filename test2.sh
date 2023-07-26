#!/bin/sh


# if [ $# -gt 0 ]; then
#     echo "success"
# else
#     echo "fail"
# fi

sed -i '' 's/http"/https"/g' environment/config.xml
sed -i '' 's/210.200.4.11"/mbbank.tcb-test.com.tw"/g' environment/config.xml
sed -i '' 's#https://mbbank\.tcb-test\.com\.tw/NMobileBank#http://210.200.4.11/MobileBankDev_P4#g' environment/environment.sit.ts
