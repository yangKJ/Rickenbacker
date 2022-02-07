use_frameworks!

platform :ios, '10.0'

target 'Rickenbacker_Example' do

#  pod 'Rickenbacker/CTMediator', :path => './'
#  pod 'Rickenbacker/HBDNavigationBar', :path => './'
#  pod 'Rickenbacker/MJRefresh', :path => './'
#  pod 'Rickenbacker/DZNEmptyDataSet', :path => './'
  
  pod 'Rickenbacker', :path => './'

  pod 'SnapKit'
  
end

## Ignore CocoaPods warnings
inhibit_all_warnings!
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['COMPILER_INDEX_STORE_ENABLE'] = "NO"
    end
  end
end
