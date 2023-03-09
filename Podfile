use_frameworks!
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '10.0'

target 'Rickenbacker_Example' do
  
#  pod 'Rickenbacker/Mediator', :path => './'
#  pod 'Rickenbacker/HBDNavigationBar', :path => './'
#  pod 'Rickenbacker/MJRefresh', :path => './'
#  pod 'Rickenbacker/DZNEmptyDataSet', :path => './'

  pod 'Rickenbacker', :path => './'
  
#  pod 'RxSwift'
#  pod 'RxCocoa'
#  pod 'CTMediator' # 组件化 target-action
#  pod 'MJRefresh' # 刷新
#  pod 'DZNEmptyDataSet' # 空数据展示
#  pod 'HBDNavigationBar' # 导航栏
  
end

## Ignore CocoaPods warnings
inhibit_all_warnings!
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['COMPILER_INDEX_STORE_ENABLE'] = "NO"
      if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 10.0
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0'
      end
    end
  end
end
