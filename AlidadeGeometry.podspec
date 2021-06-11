Pod::Spec.new do |s|
  s.name         = "AlidadeGeometry"
  s.version      = "6.0"
  s.summary      = "Utility components"

  s.homepage     = "https://github.com/netcosports/Alidade"
  s.license      = { :type => "MIT" }
  s.author = {
    'Dmitry Duleba' => 'dmitryduleba@gmail.com'
  }
  s.source       = { :git => "https://github.com/netcosports/Alidade.git", :tag => s.version.to_s }
  s.framework = ["UIKit", "Foundation"]

  s.swift_version = ['5.0', '5.1', '5.2', '5.3']

  s.platform = :ios
  s.ios.deployment_target = "10.0"

  s.dependency 'AlidadeVectors'

  s.source_files = 'Alidade/Source/Geometry/*.swift'

end
