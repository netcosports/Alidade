platform :ios, '9.0'
use_frameworks!
inhibit_all_warnings!

source 'git@github.com:CocoaPods/Specs.git'

target 'Demo' do
    pod 'Alidade', :path => './'
    pod 'SwiftLint'
end

target 'Alidade' do
    pod 'SwiftLint'
end

target 'Tests' do 
    pod 'Nimble'
    pod 'SwiftLint'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        if ['Nimble'].include? target.name
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '4.2'
            end
        end
        if ['Alidade'].include? target.name
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '5.0'
            end
        end
    end
  end