#
# Be sure to run `pod lib lint YYBBSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YYBBSDK'
  s.version          = '0.1.0'
  s.summary          = 'A short description of YYBBSDK.'
  
  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  
  s.description      = <<-DESC
  TODO: Add long description of the pod here.
  DESC
  s.homepage         = 'https://github.com/460467069@qq.com/YYBBSDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '460467069@qq.com' => '460467069@qq.com' }
  s.source           = { :git => 'https://gitee.com/www.wangruzhou.com/YYBBSDK.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  
  s.frameworks = 'UIKit'
  s.dependency 'AFNetworking'
  s.dependency 'Masonry'
  s.dependency 'YYCategories'
  s.dependency 'YYText'
  s.dependency 'YYModel'
  s.dependency 'YYCache'
  s.dependency 'YYWebImage'
  s.dependency 'SDWebImage'
  s.dependency 'MFSIdentifier'
  s.dependency 'WHC_ModelSqliteKit'
  # s.dependency 'TPKeyboardAvoiding'
  s.dependency 'IQKeyboardManager'
  s.dependency 'TZImagePickerController'
  s.dependency 'IQDropDownTextField'
  s.dependency 'MessageThrottle'
  s.dependency 'SVProgressHUD'
  s.dependency 'SHSPhoneComponent'
  s.dependency 'MJRefresh'
  s.dependency 'IGListKit'
  s.dependency 'JXCategoryView'
  s.dependency 'JXPagingView/Pager'
  s.dependency 'YCShadowView'
  s.dependency 'DZNEmptyDataSet'
  s.dependency 'SDCycleScrollView'
  s.dependency 'FDFullscreenPopGesture'
  #  s.dependency 'KMNavigationBarTransition'
  s.dependency 'HBDNavigationBar'
  #  s.dependency 'WRNavigationBar'
  s.dependency 'Qiniu'
  s.dependency 'SAMKeychain'
  s.dependency 'JLPermissions/Location'#, :git => 'git@github.com:VincentSit/JLPermissions.git'
  s.dependency 'JLPermissions/Notification'#, :git => 'git@github.com:VincentSit/JLPermissions.git'
  s.dependency 'JLPermissions/Contacts'#, :git => 'git@github.com:VincentSit/JLPermissions.git'
  s.dependency 'JLPermissions/Photos'#, :git => 'git@github.com:VincentSit/JLPermissions.git'
  s.dependency 'JLPermissions/Camera'#, :git => 'git@github.com:VincentSit/JLPermissions.git'
  s.resources = 'YYBBSDK/Assets/**/*', 'YYBBSDK/Config/*','YYBBSDK/Required/JXBWebKit/JSResources.bundle'
  
  s.static_framework = true
  
  s.default_subspecs = 'Core', 'ThirdLib', 'Pay', 'Analysis'
  
  s.subspec 'Core' do |sp|
    sp.source_files = 'YYBBSDK/Required/**/*.{h,m,swift}', 'YYBBSDK/*.h'
    sp.resources = 'YYBBSDK/Required/UI/**/*.storyboard'
    sp.public_header_files = 'YYBBSDK/Required/**/*.{h}', 'YYBBSDK/*.h'
  end
  
  #   s.xcconfig = {
  #     'Debug'=>:debug,
  #     'Release'=>:debug,
  #     'Enterprise'=>:debug,
  #     'ReleaseForRunning'=>:debug
  #   }
  
  # 登录 各个平台：需要集成哪些平台需要选择相应的平台语句
  s.subspec 'Login' do |sp|
    # Facebook
    #    sp.subspec 'Facebook' do |ssp|
    #      ssp.dependency 'YYBBSDK/Core'
    #      ssp.dependency 'FBSDKCoreKit'
    #      ssp.dependency 'FBSDKLoginKit'
    #      ssp.dependency 'FBSDKShareKit'
    #      ssp.dependency 'Bolts'
    #      # ssp.vendored_frameworks = 'YYBBSDK/Support/Login/Facebook/**/*.framework'
    #      ssp.source_files = 'YYBBSDK/Support/Login/Facebook/*.{h,m}'
    #      ssp.public_header_files = 'YYBBSDK/Support/Login/Facebook/*.{h}'
    #    end
    
    # GameCenter
    #    sp.subspec 'GameCenter' do |ssp|
    #      ssp.dependency 'YYBBSDK/Core'
    #      ssp.frameworks = 'GameKit'
    #      ssp.source_files = 'YYBBSDK/Support/Login/GameCenter/**/*.{h,m}'
    #      ssp.public_header_files = 'YYBBSDK/Support/Login/GameCenter/**/*.{h}'
    #    end
    
    # Guest
    #    sp.subspec 'Guest' do |ssp|
    #      ssp.dependency 'YYBBSDK/Core'
    #      ssp.source_files = 'YYBBSDK/Support/Login/Guest/*.{h,m}'
    #      ssp.public_header_files = 'YYBBSDK/Support/Login/Guest/*.{h}'
    #    end
    
    # Phone
    sp.subspec 'Phone' do |ssp|
      ssp.dependency 'YYBBSDK/Core'
      ssp.source_files = 'YYBBSDK/Support/Login/Phone/*.{h,m}'
      ssp.public_header_files = 'YYBBSDK/Support/Login/Phone/*.{h}'
    end
    
    # Kakao
    #    sp.subspec 'Kakao' do |ssp|
    #      ssp.dependency 'YYBBSDK/Core'
    #      ssp.dependency 'KakaoOpenSDK'
    #      ssp.source_files = 'YYBBSDK/Support/Login/Kakao/*.{h,m}'
    #      ssp.public_header_files = 'YYBBSDK/Support/Login/Kakao/*.{h}'
    #    end
    
    # Naver
    #    sp.subspec 'Naver' do |ssp|
    #      ssp.dependency 'YYBBSDK/Core'
    #      ssp.dependency 'naveridlogin-sdk-ios'
    #      ssp.source_files = 'YYBBSDK/Support/Login/Naver/*.{h,m}'
    #      ssp.public_header_files = 'YYBBSDK/Support/Login/Naver/*.{h}'
    #      #            ssp.vendored_frameworks = 'YYBBSDK/Support/Login/Naver/NaverThirdPartyLogin.framework'
    #    end
    
    # Twitter
    #    sp.subspec 'Twitter' do |ssp|
    #        ssp.dependency 'YYBBSDK/Core'
    #        ssp.dependency 'TwitterKit'
    #        ssp.frameworks = 'SafariServices'
    #        ssp.source_files = 'YYBBSDK/Support/Login/Twitter/*.{h,m}'
    #        ssp.public_header_files = 'YYBBSDK/Support/Login/Twitter/*.{h}'
    #    end
    
    # Line
    #    sp.subspec 'Line' do |ssp|
    #      ssp.dependency 'YYBBSDK/Core'
    #      ssp.dependency 'LineSDK'
    #      ssp.frameworks = 'CoreTelephony', 'Security'
    #      ssp.source_files = 'YYBBSDK/Support/Login/Line/*.{h,m}'
    #      ssp.public_header_files = 'YYBBSDK/Support/Login/Line/*.{h}'
    #    end
    
    #    sp.subspec 'Code' do |ssp|
    #      ssp.dependency 'YYBBSDK/Core'
    #      ssp.source_files = 'YYBBSDK/Support/Login/Code/*.{h,m}'
    #      ssp.public_header_files = 'YYBBSDK/Support/Login/Code/*.{h}'
    #    end
  end
  
  # Share
  s.subspec 'Share' do |sp|
    
    # Native
    #    sp.subspec 'Native' do |ssp|
    #      ssp.dependency 'YYBBSDK/Core'
    #      ssp.source_files = 'YYBBSDK/Support/Share/Native/*.{h,m}'
    #      ssp.public_header_files = 'YYBBSDK/Support/Share/Native/*.{h}'
    #    end
    
    sp.subspec 'ShareSDK' do |ssp|
      # 主模块(必须)
      ssp.dependency 'mob_sharesdk'
      # UI模块(非必须，需要用到ShareSDK提供的分享菜单栏和分享编辑页面需要以下1行)
      ssp.dependency 'mob_sharesdk/ShareSDKUI'
      # 平台SDK模块(QQ、微信、新浪微博，只需要以下3行)
      ssp.dependency 'mob_sharesdk/ShareSDKPlatforms/QQ'
      #      ssp.dependency 'mob_sharesdk/ShareSDKPlatforms/SinaWeibo'
      ssp.dependency 'mob_sharesdk/ShareSDKPlatforms/WeChatFull'
      # 使用配置文件分享模块（非必需）
      #      ssp.dependency 'mob_sharesdk/ShareSDKConfigFile'
      # 扩展模块（在调用可以弹出我们UI分享方法的时候是必需的）
      ssp.dependency 'mob_sharesdk/ShareSDKExtension'
      ssp.source_files = 'YYBBSDK/Support/Share/ShareSDK/*.{h,m}'
      ssp.public_header_files = 'YYBBSDK/Support/Share/ShareSDK/*.{h}'
      ssp.xcconfig = { 'OTHER_LDFLAGS' => '-ObjC -framework "ShareSDK" -framework "ShareSDKConnector" -framework "MOBFoundation" -framework "MOBFoundationEx" -framework "ShareSDKExtension" -framework "ShareSDKUI" -framework "WechatConnector" -l "WeChatSDK"',
        'LIBRARY_SEARCH_PATHS' => '$(inherited) "${PODS_ROOT}/mob_sharesdk/ShareSDK/Support/PlatformSDK/SinaWeiboSDK" "${PODS_ROOT}/mob_sharesdk/ShareSDK/Support/PlatformSDK/WeChatSDKFull"'
      }
    end
    
  end
  
  # 支付subspec
  s.subspec 'Pay' do |sp|
    # IAP
    sp.subspec 'AppStore' do |ssp|
      ssp.dependency 'YYBBSDK/Core'
      ssp.frameworks = 'GameKit'
      ssp.source_files = 'YYBBSDK/Support/Pay/AppStore/*.{h,m}'
      ssp.public_header_files = 'YYBBSDK/Support/Pay/AppStore/*.{h}'
    end
    #    sp.subspec 'WeChat' do |ssp|
    #      ssp.dependency 'YYBBSDK/Core'
    #      ssp.source_files = 'YYBBSDK/Support/Pay/WeChat/*.{h,m}'
    #      ssp.public_header_files = 'YYBBSDK/Support/Pay/WeChat/*.{h}'
    #    end
    
    # PayPal
    #    sp.subspec 'PayPal' do |ssp|
    #      ssp.dependency 'YYBBSDK/Core'
    #      ssp.dependency 'Braintree'
    #      ssp.source_files = 'YYBBSDK/Support/Pay/PayPal/*.{h,m}'
    #      ssp.public_header_files = 'YYBBSDK/Support/Pay/PayPal/*.{h}'
    #    end
    
    # Stripe
    #    sp.subspec 'Stripe' do |ssp|
    #      ssp.dependency 'YYBBSDK/Core'
    #      ssp.dependency 'Stripe'
    #      ssp.source_files = 'YYBBSDK/Support/Pay/Stripe/*.{h,m}'
    #      ssp.resources = 'YYBBSDK/Support/Pay/Stripe/**/*.storyboard', 'YYBBSDK/Support/Pay/Stripe/YYBBSDK_StripeResource.bundle'
    #      ssp.public_header_files = 'YYBBSDK/Support/Pay/Stripe/*.{h}'
    #    end
    
    # Adyen
    #    sp.subspec 'Adyen' do |ssp|
    #      ssp.dependency 'YYBBSDK/Core'
    #      ssp.dependency 'Adyen'
    #      ssp.source_files = 'YYBBSDK/Support/Pay/Adyen/**/*'
    #      ssp.public_header_files = 'YYBBSDK/Support/Pay/Adyen/*.{h, swift}'
    #    end
    
    # Paymentwall
    #    sp.subspec 'Paymentwall' do |ssp|
    #      ssp.dependency 'YYBBSDK/Core'
    #      ssp.source_files = 'YYBBSDK/Support/Pay/Paymentwall/*.{h,m}'
    #      ssp.resources = 'YYBBSDK/Support/Pay/Paymentwall/*.storyboard'
    #      ssp.public_header_files = 'YYBBSDK/Support/Pay/Paymentwall/*.{h}'
    #    end
    
    # 自定义UI
    sp.subspec 'PaymentUI' do |ssp|
      ssp.dependency 'YYBBSDK/Core'
      ssp.source_files = 'YYBBSDK/Support/Pay/CustomUI/*.{h,m}'
      ssp.public_header_files = 'YYBBSDK/Support/Pay/CustomUI/*.{h}'
      ssp.resources = 'YYBBSDK/Support/Pay/CustomUI/*.storyboard', 'YYBBSDK/Support/Pay/CustomUI/YYBBSDK_PaymentResource.bundle'
    end
    
    # h5
    sp.subspec 'H5' do |ssp|
      ssp.dependency 'YYBBSDK/Core'
      ssp.source_files = 'YYBBSDK/Support/Pay/H5/*.{h,m}'
      ssp.public_header_files = 'YYBBSDK/Support/Pay/H5/*.{h}'
    end
    
  end
  
  # Customer
  s.subspec 'Customer' do |sp|
    # AI
    sp.subspec 'AI' do |ssp|
      ssp.dependency 'YYBBSDK/Core'
      ssp.source_files = 'YYBBSDK/Support/Customer/AI/*.{h,m}'
      ssp.library = 'sqlite3'
      ssp.vendored_frameworks = 'YYBBSDK/Support/Customer/AI/ElvaChatServiceSDK.framework', 'YYBBSDK/Support/Customer/AI/MQTTFramework.framework'
      ssp.public_header_files = 'YYBBSDK/Support/Customer/AI/*.{h}'
      ssp.xcconfig = { 'OTHER_LDFLAGS' => '-ObjC' }
    end
    # CS
    sp.subspec 'CS' do |ssp|
      ssp.dependency 'YYBBSDK/Core'
      ssp.source_files = 'YYBBSDK/Support/Customer/CS/*.{h,m}'
      ssp.vendored_frameworks = 'YYBBSDK/Support/Customer/CS/ZendeskProviderSDK.framework', 'YYBBSDK/Support/Customer/CS/ZendeskSDK.framework'
      ssp.resources = 'YYBBSDK/Support/Customer/CS/ZendeskSDK.bundle', 'YYBBSDK/Support/Customer/CS/ZendeskSDKStrings.bundle'
      ssp.public_header_files = 'YYBBSDK/Support/Customer/CS/*.{h}'
    end
  end
  
  # Analysis
  s.subspec 'Analysis' do |sp|
    # AppsFlyer
    # sp.subspec 'AppsFlyer' do |ssp|
    #   ssp.dependency 'YYBBSDK/Core'
    #   ssp.dependency 'AppsFlyerFramework'
    #   ssp.frameworks = 'AdSupport', 'iAd'
    #   ssp.source_files = 'YYBBSDK/Support/Analysis/AppsFlyer/*.{h,m}'
    #   ssp.public_header_files = 'YYBBSDK/Support/Analysis/AppsFlyer/*.{h}'
    # end
    
    # YYBBServer  后台服务器数据上报
    # sp.subspec 'KuWan' do |ssp|
    #   ssp.dependency 'YYBBSDK/Core'
    #   ssp.source_files = 'YYBBSDK/Support/Analysis/KuWan/*.{h,m}'
    #   ssp.public_header_files = 'YYBBSDK/Support/Analysis/KuWan/*.{h}'
    # end
    
    #     Adjust
    sp.subspec 'Adjust' do |ssp|
      ssp.dependency 'YYBBSDK/Core'
      ssp.dependency 'Adjust'
      ssp.frameworks = 'AdSupport', 'iAd'
      ssp.source_files = 'YYBBSDK/Support/Analysis/Adjust/*.{h,m}'
      ssp.public_header_files = 'YYBBSDK/Support/Analysis/Adjust/*.{h}'
    end
    
    # UMCAnalytics
#    sp.subspec 'UMCAnalytics' do |ssp|
#      ssp.dependency 'YYBBSDK/Core'
#      ssp.dependency 'UMCCommon'
#      ssp.dependency 'UMCCommonLog'
#      ssp.xcconfig = { 'OTHER_LDFLAGS' => '-ObjC -framework "UMCommon" -framework "UMCommonLog"'}
#      ssp.source_files = 'YYBBSDK/Support/Analysis/UMCAnalytics/*.{h,m}'
#      ssp.public_header_files = 'YYBBSDK/Support/Analysis/UMCAnalytics/*.{h}'
#      ssp.library = 'sqlite3'
#      #       ssp.vendored_frameworks = 'YYBBSDK/Support/Analysis/UMCAnalytics/**/*.framework'
#    end
    
  end
  
  # ThirdLib 将第三方配置统一到该插件中
  s.subspec 'ThirdLib' do |sp|
    sp.subspec 'Other' do |ssp|
      ssp.dependency 'YYBBSDK/Core'
      ssp.source_files = 'YYBBSDK/Support/ThirdLib/Other/*.{h,m}'
      ssp.public_header_files = 'YYBBSDK/Support/ThirdLib/Other/*.{h}'
      ssp.xcconfig = {'OTHER_LDFLAGS' => '-ObjC'
      }
    end
  end
  
  # ThirdLib 将第三方配置统一到该插件中
  s.subspec 'ThirdLib2' do |sp|
    sp.subspec 'Other' do |ssp|
      ssp.dependency 'YYBBSDK/Core'
      ssp.source_files = 'YYBBSDK/Support/ThirdLib/Other/*.{h,m}'
      ssp.public_header_files = 'YYBBSDK/Support/ThirdLib/Other/*.{h}'
      ssp.dependency 'Bugly'
      ssp.libraries = 'z', 'c++'
      ssp.xcconfig = {'OTHER_LDFLAGS' => '-ObjC'
      }
    end
    
    sp.subspec 'PGY' do |ssp|
      ssp.dependency 'YYBBSDK/Core'
      ssp.source_files = 'YYBBSDK/Support/ThirdLib/PGY/*.{h,m}'
      ssp.public_header_files = 'YYBBSDK/Support/ThirdLib/PGY/*.{h}'
      ssp.dependency 'Pgyer'
      ssp.dependency 'PgyUpdate'
      ssp.libraries = 'z', 'c++'
      ssp.xcconfig = {'OTHER_LDFLAGS' => '-ObjC -framework "PgySDK" -framework "PgyUpdate"',
        'FRAMEWORK_SEARCH_PATHS' => '$(inherited) "${PODS_ROOT}/PgyUpdate/PgySDK/sdk" "${PODS_ROOT}/Pgyer/PgySDK/sdk"'
      }
    end
  end
  
  # 广告
  s.subspec 'AD' do |sp|
    # UP
    sp.subspec 'UP' do |ssp|
      ssp.source_files = 'YYBBSDK/Support/AD/UP/*.{h,m}'
      ssp.public_header_files = 'YYBBSDK/Support/AD/UP/*.{h}'
      ssp.vendored_frameworks = 'YYBBSDK/Support/AD/UP/**/*.framework'
      ssp.resources = 'YYBBSDK/Support/AD/UP/**/*.bundle'
      ssp.dependency 'GoogleAppMeasurement'
      ssp.dependency 'nanopb'
      ssp.dependency 'GoogleUtilities'
      ssp.libraries = 'xml2', 'resolv'
    end
  end
  
  # APNs
  s.subspec 'APNs' do |sp|
    # Firebase
    # sp.subspec 'Firebase' do |ssp|
    #   ssp.dependency 'YYBBSDK/Core'
    #   ssp.dependency 'Firebase/Core'
    #   ssp.dependency 'Firebase/Messaging'
    #   ssp.dependency 'GoogleUtilities'
    #   ssp.dependency 'FirebaseInstanceID'
    #   # Reason https://github.com/firebase/firebase-ios-sdk/issues/4154
    #   ssp.dependency 'nanopb', '0.3.901'
    #   ssp.source_files = 'YYBBSDK/Support/APNs/Firebase/*.{h,m}'
    #   ssp.public_header_files = 'YYBBSDK/Support/APNs/Firebase/*.{h}'
    # end
    
    # JPush
    sp.subspec 'JPush' do |ssp|
      ssp.dependency 'YYBBSDK/Core'
      ssp.dependency 'JPush'
      ssp.xcconfig = { 'OTHER_LDFLAGS' => '-ObjC -l "jcore-ios-2.7.1" -l "jpush-ios-3.6.2" ',
        'LIBRARY_SEARCH_PATHS' => '$(inherited) "${PODS_ROOT}/JCore" "${PODS_ROOT}/JPush"'
      }
      ssp.libraries = 'z', 'resolv'
      ssp.source_files = 'YYBBSDK/Support/APNs/JPush/*.{h,m}'
      ssp.public_header_files = 'YYBBSDK/Support/APNs/JPush/*.{h}'
    end
  end
  
end
