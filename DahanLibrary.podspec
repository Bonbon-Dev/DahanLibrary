#
# Be sure to run `pod lib lint DahanLibrary.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'DahanLibrary'
    s.version          = '1.0.3.1'
    s.summary          = 'Summary of DahanLibrary.'
    s.description      = <<-DESC
                          A description of DahanLibrary.
                         DESC
    s.homepage         = 'https://github.com/Bonbon-Dev/DahanLibrary'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Andy Meng' => 'andy_m129@163.com' }
    s.source           = { :git => 'https://github.com/Bonbon-Dev/DahanLibrary.git', :tag => s.version.to_s }
    s.social_media_url = 'https://github.com/Bonbon-Dev'
    s.ios.deployment_target = '8.0'
    s.default_subspec = 'Core'

    # Bugly
    s.subspec 'Bugly' do |bugly|
        bugly.source_files = 'DahanLibrary/Classes/Bugly/*.{h,m}'
        bugly.public_header_files = 'DahanLibrary/Classes/Bugly/*.h'
        bugly.dependency 'DahanLibrary/Core'
        bugly.dependency 'AMKCategories/Foundation/NSObject/MethodSwizzling'
        bugly.dependency 'Bugly'    
    end
    
    # UMeng
    s.subspec 'UMeng' do |umeng|
      umeng.source_files = 'DahanLibrary/Classes/UMeng/*.{h,m}'
      umeng.public_header_files = 'DahanLibrary/Classes/UMeng/*.h'
      umeng.dependency 'DahanLibrary/Core'
      umeng.dependency 'AMKCategories/Foundation/NSObject/MethodSwizzling'
      umeng.dependency 'UMCCommon'
      umeng.dependency 'UMCAnalytics'
    end
    
    # Core
    s.subspec 'Core' do |core|
        core.vendored_frameworks = [
            'DahanLibrary/Classes/Core/*.framework',
            'DahanLibrary/Classes/Core/**/*.framework',
        ]
        core.resources = [
            'DahanLibrary/Classes/Core/*.bundle',
            'DahanLibrary/Classes/Core/**/*.bundle',
        ]
        core.frameworks = 'UIKit'
        core.libraries = 'c++'
        core.pod_target_xcconfig = {'OTHER_LDFLAGS' => '-all_load', 'ENABLE_BITCODE' => 'NO'}
    end
end
