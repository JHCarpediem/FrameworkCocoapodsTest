#
# Be sure to run `pod lib lint ${POD_NAME}.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see∫ https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Diagnosis'
  s.version          = '2.09.119'
  s.summary          = 'Automotive diagnosis and Bluetooth module'
  s.swift_versions = ['4.2', '5.0', '5.1', '5.2']

  s.description      = "Diagnostic library including vehicle model library and Bluetooth module"

  s.homepage         = 'http://github.ios/Diagnosis'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'diagnosis' => 'www.abc.cn' }
  s.source           = { :git => 'http://github.ios/Diagnosis.git', :tag => s.version.to_s}
  s.resource = "Diagnosis/Classes/Diagnosis.bundle"
  s.prefix_header_file = "Diagnosis/Classes/PrefixHeader.pch"

  s.ios.deployment_target = '11.0'
  s.source_files          = "Diagnosis", "Diagnosis/Classes/**/*.{h,m,mm,swift}"
  s.vendored_frameworks = 'Diagnosis/Framework/*.framework'
  s.module_map = "Diagnosis/Classes/Diagnosis.modulemap"
  s.exclude_files = "Diagnosis/Exclude"

  s.static_framework = true
  s.xcconfig              = {'OTHER_LDFLAGS' => '-lz','VALID_ARCHS' =>  ['armv7s','arm64'].join(' ')}
  s.pod_target_xcconfig   = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => '$(ARCHS_STANDARD_64_BIT)' }
  s.user_target_xcconfig  = { 'EXCLUDED_ARCHS[spodk=iphonesimulator*]' => '$(ARCHS_STANDARD_64_BIT)' }

  
   s.dependency "FMDB", "2.7.5"
   s.dependency "YYModel", "1.0.4"
   s.dependency "SSZipArchive", "2.4.3"
   s.dependency "Masonry","1.1.0"
   s.dependency "YYText","1.0.7"
   s.dependency "Texture","3.1.0"
   s.dependency "Firebase/AnalyticsWithoutAdIdSupport"
   s.dependency "Firebase/Crashlytics"
   s.dependency "SocketRocket", "0.6.0"
   s.dependency "YBImageBrowser", "3.0.9"
   s.dependency "lottie-ios", "4.4.1"
   s.dependency "JHCampoCharts", "4.00.000"
   #s.dependency "JHCampoCharts", "3.6.0"
   s.dependency "TDBasis"
   s.dependency 'TZImagePickerController'
   s.dependency 'TDUIProvider'

   s.dependency "SnapKit" #主工程会依赖，故不写版本
   s.dependency "IQKeyboardManager" #主工程会依赖，故不写版本
   
   s.ios.framework = 'AVFAudio'

   s.libraries = [
    "c++",
    "stdc++",
  ]
end
