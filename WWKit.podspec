#
# Be sure to run `pod lib lint WWKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WWKit'
  s.version          = '0.0.4'
  s.summary          = 'WWKit基础库'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'WWKit是iOS项目通用基础库'

  s.homepage         = 'https://github.com/wuxuezhen/WWKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wuxuezhen' => 'xzzhenw@163.com' }
  s.source           = { :git => 'https://github.com/wuxuezhen/WWKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  
  s.subspec 'WWGCD' do |ss|
      ss.source_files = 'WWKit/Classes/WWGCD'
  end
  
  # s.resource_bundles = {
  #   'WWKit' => ['WWKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
    s.frameworks = 'UIKit'
    s.dependency 'MBProgressHUD'
    s.dependency 'YYKit'
    s.dependency 'AFNetworking'
    s.dependency 'MJRefresh'
end
