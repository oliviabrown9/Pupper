source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target 'Pupper' do

pod 'Alamofire'
pod 'SwiftyJSON'
pod 'CVCalendar'

post_install do |installer|
   installer.pods_project.targets.each do |target|
       target.build_configurations.each do |config|
           config.build_settings['SWIFT_VERSION'] = '4.1'
       end
   end
end

end
