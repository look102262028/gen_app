#!/bin/bash
VERSION_PATH=/Users/mac5/Documents/GitHub/gen_app/version.txt

# 有傳進來版本號使用參數 沒有從txt取得
if [ $# -gt 0 ]; then
    LAST_VERSION = $1
    # 找指定版本的目錄 
    dirs=$(find /Users/mac5/Documents/GitHub/gen_app -type d -name "*$VERSION*" | head -n 1 )
    latest_dir=$(echo $dirs | awk '{print $1}')
    echo "指定建立的目錄是：$latest_dir"
else
    LAST_VERSION=$(tail -n 1 $VERSION_PATH)  
    # 找最後一個目錄 
    dirs=$(find /Users/mac5/Documents/GitHub/gen_app/ -type d -name 'app*' -print0 | xargs -0 ls -td)
    latest_dir=$(echo $dirs | awk '{print $1}')
    echo "最晚建立的目錄是：$latest_dir"
fi
  

##build app to phone
# 檢查 Android 手機是否連接成功
ANDROID_INSTALLED=0
echo "$(adb shell getprop sys.usb.state)"
if [[ $? -eq 0 && "$(adb shell getprop sys.usb.state)" =~ "mtp" ]]; then
    echo "Android device is 可傳輸狀態."
     # 移除舊ＡＰＰ
    if adb shell pm list packages | grep com.mitake.android.bk.tcbdev; then
      echo "刪除舊ANDROID APP"
      #adb uninstall com.example.app
      adb uninstall com.mitake.android.bk.tcbdev
    fi
    # 安裝 Android APK
    adb install $latest_dir/app-debug.apk
    echo "install apk finish-"$LAST_VERSION
    ANDROID_INSTALLED=1
else
    echo "Android device is 不可傳輸狀態."
    num_devices=$(adb devices | tail -n +2 | wc -l)
    num_devices_minus_1=$((num_devices - 1))
    echo "ANDROID當前連接設備數量:"$num_devices_minus_1
    if [ $num_devices_minus_1 -gt 0 ];then 
      ANDROID_INSTALLED=2
      echo "請切換傳輸模式"
    else 
      ANDROID_INSTALLED=3
      echo "沒有ANDROID設備連接"
    fi
fi

APP_BUNDLE_ID="tw.com.tcb-bank.mbbank.uat"
# 檢查 iOS 設備是否連接成功
if [ "$(idevice_id -l | wc -l)"  -eq 1 ]; then
  # 移除舊ＡＰＰ
  if ideviceinstaller -l -o xml | xpath '//key[text()="CFBundleIdentifier"]/following-sibling::string[1][text()="tw.com.tcb-bank.mbbank.uat"]' > /dev/null; then
    ideviceinstaller -U $APP_BUNDLE_ID
    echo "已解除安裝IOS APP"
  fi
  # 安裝 iOS IPA
  ideviceinstaller -i $latest_dir/tcbb-mobile-bank.ipa
  echo "install ipa finish-"$LAST_VERSION
else 
   echo "iOS 設備未連接，請先連接設備後再執行。"
fi

if [  $ANDROID_INSTALLED -eq 1 ]; then
  echo "Android 安裝完成。"
elif [  $ANDROID_INSTALLED -eq 2 ]; then
  echo "Android 請切換傳輸模式。"
elif [  $ANDROID_INSTALLED -eq 3 ]; then
  echo "沒有ANDROID設備連接。"
else 
  echo "Android install fail"
fi
