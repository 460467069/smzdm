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
    s.ios.deployment_target = '10.0'
    
    s.frameworks = 'UIKit'
    s.dependency 'AFNetworking'
    s.dependency 'Masonry'
    s.dependency 'YYKit'
    s.dependency 'SDWebImage'
    s.dependency 'MFSIdentifier'
    s.dependency 'SDWebImage'
    s.dependency 'SVProgressHUD'
    s.dependency 'MBProgressHUD'
    s.dependency 'IQKeyboardManager'
    
    s.default_subspecs = 'Core', 'Login', 'Pay', 'Customer', 'Analysis', 'ThirdLib'
    
    s.subspec 'Core' do |sp|
        sp.source_files = 'YYBBSDK/Required/**/*.{h,m}'
        sp.resources = 'YYBBSDK/Required/UI/*.storyboard', 'YYBBSDK/Required/YYBBSDKResource.bundle'
        sp.public_header_files = 'YYBBSDK/Required/**/*.h'
        sp.prefix_header_file = 'YYBBSDK/Required/YYBBSDKPrefixHeader.pch'
    end
    
    # 登录 各个平台：需要集成哪些平台需要选择相应的平台语句
    s.subspec 'Login' do |sp|
        # Facebook
        sp.subspec 'Facebook' do |ssp|
            ssp.source_files = 'YYBBSDK/Support/Login/Facebook/*.{h,m}'
            ssp.public_header_files = 'YYBBSDK/Support/Login/Facebook/*.{h}'
            ssp.vendored_frameworks = 'YYBBSDK/Support/Login/Facebook/FBSDKCoreKit.framework', 'YYBBSDK/Support/Login/Facebook/Bolts.framework', 'YYBBSDK/Support/Login/Facebook/FBSDKLoginKit.framework', 'YYBBSDK/Support/Login/Facebook/FBSDKShareKit.framework'
        end
        
        # GameCenter
        sp.subspec 'AppStore' do |ssp|
            ssp.frameworks = 'GameKit'
            ssp.source_files = 'YYBBSDK/Support/Login/GameCenter/**/*.{h,m}'
            ssp.public_header_files = 'YYBBSDK/Support/Login/GameCenter/**/*.{h}'
        end
        
        # Guest
        sp.subspec 'Guest' do |ssp|
            ssp.source_files = 'YYBBSDK/Support/Login/Guest/*.{h,m}'
            ssp.public_header_files = 'YYBBSDK/Support/Login/Guest/*.{h}'
        end
        
        # Kakao
        sp.subspec 'Kakao' do |ssp|
            ssp.source_files = 'YYBBSDK/Support/Login/Kakao/*.{h,m}'
            ssp.vendored_frameworks = 'YYBBSDK/Support/Login/Kakao/KakaoCommon.framework', 'YYBBSDK/Support/Login/Kakao/KakaoLink.framework', 'YYBBSDK/Support/Login/Kakao/KakaoOpenSDK.framework'
            ssp.public_header_files = 'YYBBSDK/Support/Login/Kakao/*.{h}'
        end
        
        # Naver
        sp.subspec 'Naver' do |ssp|
            ssp.source_files = 'YYBBSDK/Support/Login/Naver/*.{h,m}'
            ssp.public_header_files = 'YYBBSDK/Support/Login/Naver/*.{h}'
            ssp.vendored_frameworks = 'YYBBSDK/Support/Login/Naver/NaverThirdPartyLogin.framework'
        end
        
        # Twitter
        sp.subspec 'Twitter' do |ssp|
            ssp.frameworks = 'SafariServices'
            ssp.dependency 'TwitterKit'
            ssp.source_files = 'YYBBSDK/Support/Login/Twitter/*.{h,m}'
            ssp.public_header_files = 'YYBBSDK/Support/Login/Twitter/*.{h}'
        end
        
        # Line
        sp.subspec 'Line' do |ssp|
            ssp.frameworks = 'CoreTelephony', 'Security'
            ssp.source_files = 'YYBBSDK/Support/Login/Line/*.{h,m}'
            ssp.public_header_files = 'YYBBSDK/Support/Login/Line/*.{h}'
            ssp.vendored_frameworks = 'YYBBSDK/Support/Login/Line/LineSDK.framework'
        end
    end
    
    # 支付subspec
    s.subspec 'Pay' do |sp|
        # 自定义UI
        sp.subspec 'PaymentUI' do |ssp|
            ssp.source_files = 'YYBBSDK/Support/Pay/CustomUI/*.{h,m}'
            ssp.public_header_files = 'YYBBSDK/Support/Pay/CustomUI/*.{h}'
            ssp.resources = 'YYBBSDK/Support/Pay/CustomUI/*.storyboard', 'YYBBSDK/Support/Pay/CustomUI/YYBBSDK_PaymentResource.bundle'
        end
        
        # IAP
        sp.subspec 'AppStore' do |ssp|
            ssp.frameworks = 'GameKit'
            ssp.source_files = 'YYBBSDK/Support/Pay/AppStore/*.{h,m}'
            ssp.public_header_files = 'YYBBSDK/Support/Pay/AppStore/*.{h}'
        end
        
        # PayPal
        sp.subspec 'PayPal' do |ssp|
            ssp.dependency 'Braintree'
            ssp.source_files = 'YYBBSDK/Support/Pay/PayPal/*.{h,m}'
            ssp.public_header_files = 'YYBBSDK/Support/Pay/PayPal/*.{h}'
        end

        # Adyen
        sp.subspec 'Adyen' do |ssp|
            ssp.dependency 'Adyen'
            ssp.source_files = 'YYBBSDK/Support/Pay/Adyen/**/*'
            ssp.public_header_files = 'YYBBSDK/Support/Pay/Adyen/*.{h, swift}'
        end

        # Stripe
        sp.subspec 'Stripe' do |ssp|
            ssp.dependency 'Stripe'
            ssp.source_files = 'YYBBSDK/Support/Pay/Stripe/*.{h,m}'
            ssp.resources = 'YYBBSDK/Support/Pay/Stripe/**/*.storyboard', 'YYBBSDK/Support/Pay/Stripe/YYBBSDK_StripeResource.bundle'
            ssp.public_header_files = 'YYBBSDK/Support/Pay/Stripe/*.{h}'
        end
        
        # Paymentwall
        sp.subspec 'Paymentwall' do |ssp|
            ssp.source_files = 'YYBBSDK/Support/Pay/Paymentwall/*.{h,m}'
            ssp.resources = 'YYBBSDK/Support/Pay/Paymentwall/*.storyboard'
            ssp.public_header_files = 'YYBBSDK/Support/Pay/Paymentwall/*.{h}'
        end
    end
    
    # Customer
    s.subspec 'Customer' do |sp|
        
        # AI
        sp.subspec 'AI' do |ssp|
            ssp.source_files = 'YYBBSDK/Support/Customer/AI/*.{h,m}'
            ssp.library = 'sqlite3'
            ssp.vendored_frameworks = 'YYBBSDK/Support/Customer/AI/ElvaChatServiceSDK.framework', 'YYBBSDK/Support/Customer/AI/MQTTFramework.framework'
            #            ssp.resources = 'YYBBSDK/Support/Customer/AI/ElvaChatServiceSDK.bundle'
            ssp.public_header_files = 'YYBBSDK/Support/Customer/AI/*.{h}'
            ssp.xcconfig = { 'OTHER_LDFLAGS' => '-ObjC' }
        end
        # CS
        sp.subspec 'CS' do |ssp|
            ssp.source_files = 'YYBBSDK/Support/Customer/CS/*.{h,m}'
            ssp.vendored_frameworks = 'YYBBSDK/Support/Customer/CS/ZendeskProviderSDK.framework', 'YYBBSDK/Support/Customer/CS/ZendeskSDK.framework'
            ssp.resources = 'YYBBSDK/Support/Customer/CS/ZendeskSDK.bundle', 'YYBBSDK/Support/Customer/CS/ZendeskSDKStrings.bundle'
            ssp.public_header_files = 'YYBBSDK/Support/Customer/CS/*.{h}'
        end
    end
    
    # Analysis
    s.subspec 'Analysis' do |sp|
        
        # AppsFlyer
        sp.subspec 'AppsFlyer' do |ssp|
            ssp.frameworks = 'AdSupport', 'iAd'
            ssp.source_files = 'YYBBSDK/Support/Analysis/AppsFlyer/*.{h,m}'
            ssp.public_header_files = 'YYBBSDK/Support/Analysis/AppsFlyer/*.{h}'
            ssp.vendored_frameworks = 'YYBBSDK/Support/Analysis/AppsFlyer/AppsFlyerLib.framework'
        end
        
        # YYBBServer  后台服务器数据上报
        sp.subspec 'YYBBServer' do |ssp|
            ssp.source_files = 'YYBBSDK/Support/Analysis/YYBBServer/*.{h,m}'
            ssp.public_header_files = 'YYBBSDK/Support/Analysis/YYBBServer/*.{h}'
        end
    end
    
    # ThirdLib 将第三方配置统一到该插件中
    s.subspec 'ThirdLib' do |sp|
        sp.source_files = 'YYBBSDK/Support/ThirdLib/*.{h,m}'
        sp.public_header_files = 'YYBBSDK/Support/ThirdLib/*.{h}'
        sp.dependency 'FLEX'
        sp.vendored_frameworks = 'YYBBSDK/Support/ThirdLib/Bugly/Bugly.framework', 'YYBBSDK/Support/ThirdLib/Fabric/Crashlytics.framework', 'YYBBSDK/Support/ThirdLib/Fabric/Fabric.framework'
        sp.frameworks = 'SystemConfiguration', 'Security'
        sp.libraries = 'z', 'c++'
    end
    
    #    # APNs
    #    s.subspec 'YYBBSDKAPNs' do |sp|
    #        # GeTui
    #        sp.subspec 'GeTui' do |ssp|
    #            ssp.dependency 'GTSDK'
    #            ssp.source_files = 'YYBBSDK/Support/APNs/GePush/*.{h,m}'
    #            ssp.public_header_files = 'YYBBSDK/Support/APNs/GePush/*.{h}'
    #        end
    #    end
    
end
