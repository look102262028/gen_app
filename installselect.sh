#!/bin/bash
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
        latest_dir="$directory"
        foldername=$(basename $latest_dir)
        echo $latest_dir
        echo "install foldername: "$foldername
    fi
fi
############################################

##build app to phone
# 檢查 Android 手機是否連接成功
ANDROID_INSTALLED=0
if [ "$(adb devices | tail -n +2 | wc -l)" != 0 ]; then
  # 移除舊ＡＰＰ
  if adb shell pm list packages | grep com.mitake.android.bk.tcbdev; then
    echo "刪除舊ANDROID APP"
    adb uninstall com.example.app
  fi
  # 安裝 Android APK
  adb install $latest_dir/app-debug.apk
  echo "install apk finish-"$VERSION
  ANDROID_INSTALLED=1
fi

APP_BUNDLE_ID="tw.com.tcb-bank.mbbank.uat"
IOS_INSTALLED=0
# 檢查 iOS 設備是否連接成功
if [ "$(idevice_id -l | wc -l)"  != 0 ]; then
  # 移除舊ＡＰＰ
  if ideviceinstaller -l -o xml | xpath '//key[text()="CFBundleIdentifier"]/following-sibling::string[1][text()="tw.com.tcb-bank.mbbank.uat"]' > /dev/null; then
    ideviceinstaller -U $APP_BUNDLE_ID
    echo "已解除安裝IOS APP"
  fi
  # 安裝 iOS IPA
  ideviceinstaller -i $latest_dir/tcbb-mobile-bank.ipa
  echo "install ipa finish-"$VERSION
  IOS_INSTALLED=1
fi
  

if [ $ANDROID_INSTALLED -eq 0 ]; then
  echo "Android 手機未連接，請先連接手機後再執行。"
fi
if [ $IOS_INSTALLED -eq 0 ]; then
  echo "iOS 設備未連接，請先連接設備後再執行。"
fi
