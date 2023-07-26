// The file contents for the current environment will overwrite these during build.
// The build system defaults to the dev environment which uses `environment.ts`, but if you do
// `ng build --env=prod` then `environment.prod.ts` will be used instead.
// The list of which env maps to which file can be found in `.angular-cli.json`.

export const environment = {
  PRODUCTION: false,
  SERVER_URL: 'http://210.200.4.11/MobileBankDev_P4', // Server位置(開發)
  // SERVER_URL: 'https://mbbank.tcb-test.com.tw/NMobileBank', // Server位置(UAT測試)
  API_URL: '/mnbjsonrequest/command.rest',  // api入口(電文路徑)
  ONLINE: true, // 是否連線測試
  CERT_CHECK: false,
  NATIVE: true, // 是否build到手機上測試
  LANGUAGE: true, // 啟動語系變更功能
  GOOGLE_MAP_API_KEY: 'AIzaSyBIp-p78B1drBVQ6Tb1EsY0MNJSfkp3jnE',
  AD_SLIDE_SPEED: 5000,
  AUTOLOGOUT_TIME: 600,  // 自動登出時間(秒)
  WARNING_BEFORE_LOGOUT_TIME: 60,  // 自動登出前提示時間(秒)
  // LOG level: OFF > ERROR > WARN > INFO > DEBUG > LOG
  // 當array時(開發用)，可吐出多種step('LOG_LEVEL allow string')
  LOG_LEVEL: ['ERROR', 'Cache', 'Telegram', 'Epay', 'Security'],
  // 三段電文模組路徑
  HTTP_TIMEOUT: 180000,
  USE_INTERNEL_PUBLIC_KEY: false,
  REGISTER: '/mnb/challenge/register.rest',
  HAND_SHAKE: '/mnb/challenge/handshake.rest',
  EXCHANGE_KEY: '/mnb/challenge/exchange.rest',
  DOWNLOAD_PATCH: '/mnb/downloadpatch/*.rest?t=/*',
  AUTHORIZATION_KEY: 'hitrust_auth',
  AUTH_TOKEN_KEY: 'auth_token',
  // 模擬電文模擬秒數
  SIMULATION_TIME: 1000,
  // 智能客服
  ROBOT_URL: 'http://robot.tcb-test.com.tw:8080/wise?ch=app',
  // SSO Web
  SSO_WEB_URL:'https://mbbank.tcb-test.com.tw/TCB.PRIVATE.SERVICE',
  SSO_TRANSFER_URL:'https://mbbank.tcb-test.com.tw/TCB.PRIVATE.SERVICE/gotosso.html',
  SSO_EBILL_PAID_URL: 'https://mbbank.tcb-test.com.tw/TCB.PRIVATE.SERVICE/authorize/v1.0/ssoWeb/ebillPaidNotification',
  // SSO 基金到價通知
  SSO_FUND_PRICE_URL:'https://mbbank.tcb-test.com.tw/TCB.PRIVATE.SERVICE/authorize/v1.0/ssoWeb/fundPriceNotice/api/ssoEntrance',
  //SSO SMART Web
  SSO_SMART_URL:'https://irobo.tcb-test.com.tw/irobo/sso',
  // SSO 信貸
  LOAN_WEB_URL:'https://mbbank.tcb-test.com.tw/TCB.LOAN.SERVICE',
  // 大數據JS
  // CELEBRUS_JS: 'lib/CelebrusInsert.js',
  // PUSH
  PUSH_URL: 'https://push.tcb-test.com.tw/STRING/',
  PUSH_ANDROID_APPID: 'TCB_Android_UAT',
  PUSH_IOS_APPID: 'TCB_iOS_UAT',
  // DirectUpdate檢查
  DIRECTUPDATE: true,
  // 財金交易入口服務網址
  // SSO信用卡申請服務網址 (信用卡掃描QRCode)
  SSO_APPLYCARD_URL: 'https://cobank.tcb-test.com.tw/TCB.PRIVATE.SERVICE/#/card-center/apply-card/main',
  FISC_URL: 'https://www.focas-test.fisc.com.tw/FOCAS_WS/API20/QRP/V2/',
  eOpenWeb: 'https://tmopenwt.tcfhc-sec.com.tw/eOpenWeb/#/home',
  TCBWeb : 'https://stkweb1t.tcfhc-sec.com.tw/TCBWeb/WebLogin.aspx',
  //-----------------------[ADM參數]---------------------------//
  ROOT_PATH:"www",
  ADM_RECORDE_FILE_PATH:'www/ht_file/adm.txt',
  ADM_PATCH_DIR_PATH:'www/resource'
};
