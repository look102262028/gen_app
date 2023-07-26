#!/bin/bash

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
read -p "請輸入版本: " NEW_VERSION
echo "version: " $NEW_VERSION
###更改環境設定-26###
sed -i '' 's/https"/http"/g' $SOURCE_HOME/config/cordova/uat/config.xml
sed -i '' 's/mbbank.tcb-test.com.tw"/210.200.4.11"/g' $SOURCE_HOME/config/cordova/uat/config.xml
sed -i '' 's#https://mbbank\.tcb-test\.com\.tw/NMobileBank#http://210.200.4.11/MobileBankDev_P4#g' environment/environment.sit.ts

if [ -z "$NEW_VERSION" ];  then
    ###get version###
    VERSION_PATH=/Users/mac5/Documents/gen_app/version.txt
    LAST_VERSION=$(tail -n 1 $VERSION_PATH)     
    NEW_VERSION=$(echo "scale=2; $LAST_VERSION+0.1" | bc)
    echo 'NEW_VERSION: '$NEW_VERSION
    NEW_VERSION=$(printf "%.1f\n" $NEW_VERSION)
    echo $NEW_VERSION >>$VERSION_PATH 
    ###build app start###
fi

echo 'NEW_VERSION:'$NEW_VERSION ', SOURCE_HOME:' $SOURCE_HOME


cd $SOURCE_HOME
node prepare.js -r $NEW_VERSION -o 
echo "prepare finish !!!"
###build app over###

OUTPUT_PATH=/Users/mac5/Documents/gen_app/app\(${NEW_VERSION}\)_P4_$(date +"%m%d_%H%M")
echo "build app start !!!"
###apk###
##tcb.R=>tcbdev.R
ANDROID_R_PATH1=$SOURCE_HOME/cordova/platforms/android/app/src/main/java/com/hitrust/plugin/push/SysFirebaseMessagingService.java
ANDROID_R_PATH2=$SOURCE_HOME/cordova/platforms/android/app/src/main/java/com/hitrust/plugin/push/PushNotificationPlugin.java
sed -i '' 's/tcb\.R/tcbdev\.R/g' $ANDROID_R_PATH1
sed -i '' 's/tcb\.R/tcbdev\.R/g' $ANDROID_R_PATH2
cd $SOURCE_HOME/cordova/platforms/android
./gradlew assembleDebug
mkdir $OUTPUT_PATH
mv ./app/build/outputs/apk/debug/*.apk  $OUTPUT_PATH/

###ipa###
cd $SOURCE_HOME/cordova/platforms/ios
# Copy xcode project
cp -f ./project.uat.pbxproj ./tcbb-mobile-bank.xcodeproj/project.pbxproj
# Create build directory
mkdir -p ht_build/tcb_build_tag
KEYSTORE_PWD=1234
security unlock-keychain -p KEYSTORE_PWD /Users/mac5/Library/Keychains/login.keychain
# archive  project
echo "[ Build Info ] Archive......"
xcodebuild archive -scheme tcbb-mobile-bank -target tcbb-mobile-bank -archivePath ./ht_build/tcb_build_tag.xcarchive
# Export  archive
echo "[ Build Info ] Export Archive......"
xcodebuild -exportArchive -archivePath ./ht_build/tcb_build_tag.xcarchive -exportOptionsPlist /Users/mac5/Documents/gen_app/ExportOptions.plist -exportPath $OUTPUT_PATH
echo "export Archive finish..."
rm $OUTPUT_PATH/*.plist
rm $OUTPUT_PATH/*.log
rm -rf ht_build
open $OUTPUT_PATH

##build app to phone
cd /Users/mac5/Documents/gen_app
./installapp.sh $NEW_VERSION

