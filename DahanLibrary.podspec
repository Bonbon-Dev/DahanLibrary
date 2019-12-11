#
# Be sure to run `pod lib lint DahanLibrary.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'DahanLibrary'
    s.version          = '0.1.1'
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
