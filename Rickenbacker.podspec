#
# Be sure to run 'pod lib lint Rickenbacker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Rickenbacker'
  s.version          = '0.1.0'
  s.summary          = 'MVVM + RxSwift Project Architecture.'
  
  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  
  s.homepage         = 'https://github.com/yangKJ/Rickenbacker'
  s.description      = 'https://github.com/yangKJ/Rickenbacker/blob/master/README.md'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yangkejun' => 'ykj310@126.com' }
  s.source           = { :git => 'https://github.com/yangKJ/Rickenbacker.git', :tag => "#{s.version}" }
  s.social_media_url = 'https://juejin.cn/user/1987535102554472/posts'
  
  s.ios.deployment_target = '10.0'
  s.swift_version    = '5.0'
  s.requires_arc     = true
  s.static_framework = true
  s.module_name      = 'Rickenbacker'
  
  s.subspec 'Extension' do |xx|
    xx.source_files = 'Sources/Extension/*.swift'
  end
  
  s.subspec 'CatHome' do |xx|
    xx.source_files = 'Sources/CatHome/*.swift'
    xx.resource_bundles = { 'Rickenbacker' => ['Sources/CatHome/*.{xcassets,lproj}'] }
  end
  
  s.subspec 'BeeBox' do |xx|
    xx.source_files = 'Sources/BeeBox/*.swift'
    xx.dependency 'RxSwift'
    xx.dependency 'RxCocoa'
  end
  
  s.subspec 'Adapter' do |xx|
    xx.source_files = 'Sources/Adapter/*.swift'
    xx.dependency 'Rickenbacker/CatHome'
    xx.dependency 'RxSwift'
    xx.dependency 'RxCocoa'
  end
  
  s.subspec 'CTMediator' do |xx|
    xx.source_files = 'Sources/CTMediator/*.{h,swift}'
    xx.prefix_header_contents = '#import "Rickenbacker-Bridging-Header.h"'
    xx.dependency 'CTMediator'
  end
  
  s.subspec 'HBDNavigationBar' do |xx|
    xx.source_files = 'Sources/HBDNavigationBar/*.swift'
    xx.dependency 'HBDNavigationBar'
  end
  
  s.subspec 'MJRefresh' do |xx|
    xx.source_files = 'Sources/MJRefresh/*.swift'
    xx.dependency 'Rickenbacker/Adapter'
    xx.dependency 'MJRefresh'
  end
  
  s.subspec 'DZNEmptyDataSet' do |xx|
    xx.source_files = 'Sources/DZNEmptyDataSet/*.swift'
    xx.dependency 'Rickenbacker/Adapter'
    xx.dependency 'DZNEmptyDataSet'
  end
  
end
