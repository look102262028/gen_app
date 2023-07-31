#!/bin/bash
read -p "請輸入版本: " input
VERSION=$input
if [[ "$input" != *.* ]]; then
  VERSION="${input%?}.${input: -1}"
fi
directory=$(find /Users/mac5/Documents/GitHub/gen_app -type d -name "*$VERSION*" | head -n 1 )

# 检查是否找到目录
if [ -z "$VERSION" ]; then
    echo "not found"
else
    # 搜索包含特定字符串的目录
    directory=$(find /Users/mac5/Documents/GitHub/gen_app -type d -name "*$VERSION*" | head -n 1)
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
    echo "install apk finish-"$VERSION
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
exit

APP_BUNDLE_ID="tw.com.tcb-bank.mbbank.uat"
IOS_INSTALLED=0
# 檢查 iOS 設備是否連接成功
if [ "$(idevice_id -l | wc -l)"  -eq 1 ]; then
  # 移除舊ＡＰＰ
  if ideviceinstaller -l -o xml | xpath '//key[text()="CFBundleIdentifier"]/following-sibling::string[1][text()="tw.com.tcb-bank.mbbank.uat"]' > /dev/null; then
    ideviceinstaller -U $APP_BUNDLE_ID
    echo "已解除安裝IOS APP"
  fi
  # 安裝 iOS IPA
  ideviceinstaller -i $latest_dir/tcbb-mobile-bank.ipa
  echo "install ipa finish-"$VERSION
  IOS_INSTALLED=1
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
