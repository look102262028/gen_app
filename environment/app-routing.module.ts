import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { SelectivePreloadingStrategy } from '@core/navgator/selective-preloading-strategy'; // pre load lazy loading
// ---------------- Service Start ---------------- //
import { LoginRequired } from '@core/auth/login-required.service';
import { CheckCameraStatus } from '@core/auth/check-camera-status.service';

import { LogoutRequired } from '@core/auth/logout-required.service';
import { TrustedDeviceRequired } from '@core/auth/trusted-device-required.service';

import { TakeNumberRequired } from '@core/auth/take-number-required.service';
// ---------------- Pages Start ---------------- //
import { HomePageComponent } from '@pages/home/home-page/home-page.component';
// import { UserHomePageComponent } from '@pages/home/user-home-page/user-home-page.component';

const routes: Routes = [
  { path: '', redirectTo: 'home', pathMatch: 'full' },

  // 要處理的 Product APP 頁面
  // { path: 'lazy', loadChildren: '@pages/demo/lazyload.module#LazyloadModule' }, // 測試使用
  {
    // == 框架與系統相關其他功能 == //
    path: 'layout', loadChildren: '@pages/layout/layout.module#LayoutModule'
    , data: {
      preload: true
    }
    // ,canActivate: [LogoutRequired]
  },
  // 首頁
  {
    path: 'home', loadChildren: '@pages/home/home.module#HomeModule'
    , data: {
      preload: true
    }
    ,canActivate: [CheckCameraStatus]
  },
  {
    path: 'edit', loadChildren: '@pages/edit/edit.module#EditModule'
    , data: {
      preload: false
    }
  },
  {
    path: 'login', loadChildren: '@pages/login/login.module#LoginModule'
    , data: {
      preload: true
    }
    // ,canActivate: [LogoutRequired]
  },
  // ======================================== 共用功能 ======================================== //

  {
    // == 訊息頁 == //
    path: 'result', loadChildren: '@pages/result/result.module#ResultModule'
    , data: {
      preload: false
    }
    ,canActivate: [CheckCameraStatus]
  },
  {
    // == 掃碼？ == //
    path: 'scan', loadChildren: '@pages/scan/scan.module#ScanModule'
    , data: {
      preload: false
    }
  },
  {
    // == ？ == //
    path: 'micro-interaction', loadChildren: '@shared/popup/micro-interaction/micro-interaction.module#microInteractionModule'
    , data: {
      preload: false
    }
  },
  {
    // == 信卡footer == //
    path: 'card-footer', loadChildren: '@shared/card-footer/card-footer.module#cardFooterModule'
    , data: {
      preload: false
    }
  },


  // ======================================== 業務功能 ======================================== //
  {
    // == 存款查詢 == //
    path: 'deposit', loadChildren: '@pages/deposit/deposit.module#DepositModule'
    , data: {
      preload: false
    }
    , canActivate: [LoginRequired,CheckCameraStatus]
  },
  // {
  //   // == 外匯業務 == //
  //   path: 'foreign-exchange', loadChildren: '@pages/foreign-exchange/foreign-exchange.module#ForeignExchangeModule'
  //   , data: {
  //     preload: false
  //   }
  //   , canActivate: [LoginRequired,CheckCameraStatus]
  // },
  // {
  //   // == 授信業務 == //
  //   path: 'credit', loadChildren: '@pages/credit/credit.module#CreditModule'
  //   , data: {
  //     preload: false
  //   }
  //   , canActivate: [LoginRequired,CheckCameraStatus]
  // },
  // {
  //   // == 基金業務 == //
  //   path: 'fund', loadChildren: '@pages/fund/fund.module#FundModule'
  //   , data: {
  //     preload: true
  //   }
  //   , canActivate: [LoginRequired,CheckCameraStatus]
  // },
  // {
  //   // == 黃金存摺 == //
  //   path: 'gold-business', loadChildren: '@pages/gold-business/gold-business.module#GoldBusinessModule'
  //   , data: {
  //     preload: false
  //   }
  //   , canActivate: [LoginRequired,CheckCameraStatus]
  // },
  {
    // == 轉帳業務 == //
    path: 'transfer', loadChildren: '@pages/transfer/transfer.module#TransferModule'
    , data: {
      preload: false
    }
    , canActivate: [LoginRequired,CheckCameraStatus]
  },
  // {
  //   // == 繳稅費 == //
  //   path: 'taxes-fees', loadChildren: '@pages/taxes/taxes-fees.module#TaxesFeesModule'
  //   , data: {
  //     preload: false
  //   }
  //   , canActivate: [TrustedDeviceRequired,CheckCameraStatus] // 檢測是否有JB/Root
  // },
  {
    // == 安控管理 == //
    path: 'security', loadChildren: '@pages/security/security.module#SecurityModule'
    , data: {
      preload: true
    }
    , canActivate: [CheckCameraStatus] // 讓使用者可以看到選單
  },
  // {
  //   // == 訊息總覽 == //
  //   path: 'msg-overview', loadChildren: '@pages/msg-overview/msg-overview.module#MsgOverviewModule'
  //   , data: {
  //     preload: false
  //   }
  //   // , canActivate: [LoginRequired] // 讓使用者可以看到選單
  // },
  {
    // == 其他服務(使用者資訊設定) == //
    path: 'user-set', loadChildren: '@pages/user-set/user-set.module#UserSetModule'
    , data: {
      preload: false
    }
    , canActivate: [CheckCameraStatus]
  },

  // ======================================== 其他功能 ======================================== //
  // {
  //   // == 金融資訊 == //
  //   path: 'financial', loadChildren: '@pages/financial/financial.module#FinancialModule'
  //   , data: {
  //     preload: true // 首頁效果要漂亮先載入為佳
  //   }
  //   , canActivate: [CheckCameraStatus]
  // },
  // {
  //   // == 最新消息 == //
  //   path: 'news', loadChildren: '@pages/news/news.module#NewsModule'
  //   , data: {
  //     preload: false
  //   }
  //   , canActivate: [CheckCameraStatus]
  // },
  // {
  //   // == 合庫證券專區 == //
  //   path: 'stock-area', loadChildren: '@pages/stock-area/stock-area.module#StockAreaModule'
  //   , data: {
  //     preload: false
  //   }
  //   , canActivate: [LoginRequired]
  // },
  // {
  //   // == 合庫行員專區 == //
  //   path: 'teller-area', loadChildren: '@pages/teller-area/teller-area.module#TellerAreaModule'
  //   , data: {
  //     preload: false
  //   }
  //   , canActivate: [LoginRequired]
  // },
  // {
  //   // == 服務據點 == //
  //   path: 'location', loadChildren: '@pages/location/location.module#LocationModule'
  //   , data: {
  //     preload: false
  //   }
  // },
  // {
  //   // == 線上取號 == //
  //   path: 'take-number', loadChildren: '@pages/take-number/take-number.module#TakeNumberModule'
  //   , data: {
  //     preload: false
  //   }
  //   , canActivate: [CheckCameraStatus]
  //   // , canActivate: [TakeNumberRequired]
  // },
  {
    // == 其他外連專區 == //
    path: 'other-service', loadChildren: '@pages/other-service/other-service.module#OtherServiceModule'
    , data: {
      preload: false
    }
  },


  // ======================================== 特殊專區 ======================================== //
  // {
  //   // == 醫療服務&產壽險服務 == //
  //   path: 'hospital', loadChildren: '@pages/hospital/hospital.module#HospitalModule'
  //   , data: {
  //     preload: false
  //   }
  // },
  {
    // == 信用卡 == //
    path: 'card', loadChildren: '@pages/card/card.module#CardModule'
    , data: {
      preload: false
    }
  },
  {
    // == 合庫epay == //
    path: 'epay', loadChildren: '@pages/epay/epay.module#EpayModule'
    , data: {
      preload: false
    }
    , canActivate: [LoginRequired]// TrustedDeviceRequired檢測是否有JB/Root
  },
{
    // == 信用卡epay == //
    path: 'epay-card', loadChildren: '@pages/epay-card/epay-card.module#EpayCardModule'
    , data: {
      preload: false
    }
    , canActivate: [LoginRequired]
  },
  {
    // == 線上櫃台 == //
    path: 'front-desk', loadChildren: '@pages/front-desk/front-desk.module#FrontDeskModule'
    , data: {
      preload: false
    }
  },
   // ======================================== 無障礙 ======================================== //
  //  {
  //   // == 無障礙登入後首頁 == //
  //   // 若要模擬使用無障礙功能，須至 app.component.ts 設定 appMode = { isA11y: true, backNormal: false };
  //   // 並將瀏覽器 Local Storage 中的 appMode 刪除，重新整理後即可進入無障礙功能
  //   path: 'a11y', loadChildren: '@pages/a11y/a11y.module#A11yModule'
  //   , data: {
  //     preload: false
  //   }
  // },
  {
    // == 無卡提款 == //
    path: 'nocard', loadChildren: '@pages/nocard/nocard.module#NocardModule'
    , data: {
      preload: false
    }
    , canActivate: [LoginRequired]
  },
  {
    // == 線上申貸 == //
    path: 'online-loan', loadChildren: '@pages/online-loan/online-loan.module#OnlineLoanModule'
    , data: {
      preload: false
    }
  },
  // {
  //   // == 記帳庫 == //
  //   path: 'keepbooks', loadChildren: '@pages/keepbooks/keepbooks.module#KeepbooksModule'
  //   , data: {
  //     preload: false
  //   }
  //   , canActivate: [LoginRequired]
  // },
  // {
  //   // == 智能語音 == //
  //   path: 'ai-system', loadChildren: '@pages/ai-system/ai-system.module#AiSystemModule'
  //   , data: {
  //     preload: false
  //   }
  //   , canActivate: [LoginRequired]
  // },
  {
    path: '**', // any other
    redirectTo: 'home'
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes, {
    useHash: true
    , preloadingStrategy: SelectivePreloadingStrategy
  })],
  exports: [RouterModule]
})
export class AppRoutingModule { }
