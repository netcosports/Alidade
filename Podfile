platform :ios, '11.0'

#use_frameworks!
inhibit_all_warnings!

target 'Tests_iOS' do

  pod "Alidade", :path => '.'
  pod "AlidadeCoreAnimation", :path => '.'
  pod "AlidadeFunctionalAnimation", :path => '.'
  pod "AlidadeGeometry", :path => '.'
  pod "AlidadeVectors", :path => '.'

  pod 'Nimble'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        if target.name == "Nimble"
            target.build_configurations.each do |config|
                xcconfig_path = config.base_configuration_reference.real_path
                xcconfig = File.read(xcconfig_path)
                new_xcconfig = xcconfig.sub('lswiftXCTest', 'lXCTestSwiftSupport')
                File.open(xcconfig_path, "w") { |file| file << new_xcconfig }
            end
        end
    end
end
