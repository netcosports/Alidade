Pod::Spec.new do |s|

  s.name         = "Utility"
  s.version      = "0.1.6"
  s.license      = { :type => "MIT", :file => "LICENSE.md" }
  s.summary      = "Utility components"
  s.homepage     = "https://github.com/dDomovoj/Utility"
  s.author       = "dDomovoj"
  s.source       = { :git => "https://github.com/dDomovoj/Utility.git", :tag => s.version }

  s.ios.deployment_target = "9.0"
  s.default_subspec = 'Default'

  s.subspec 'Default' do |ss|
    ss.dependency 'Utility/Core'
    ss.dependency 'Utility/Formatter'
    ss.dependency 'Utility/Vectors'
    ss.dependency 'Utility/String'
    ss.dependency 'Utility/UI'
    ss.dependency 'Utility/UIExtension'
  end

  s.subspec 'Core' do |ss|
    ss.source_files = 'Utility/Source/Core/*.swift'
  end

  s.subspec 'Formatter' do |ss|
    ss.source_files = 'Utility/Source/Formatter/*.swift'
  end

  s.subspec 'Geometry' do |ss|
    ss.source_files = 'Utility/Source/Geometry/*.swift'
    ss.dependency 'Utility/Core'
    ss.dependency 'Utility/Vectors'
  end

  s.subspec 'Vectors' do |ss|
    ss.source_files = 'Utility/Source/Vectors/*.swift'
    ss.dependency 'Interpolate'
  end

  # s.subspec 'Other' do |ss|
  #   ss.source_files = 'Utility/Other/*.swift'
  # end

  s.subspec 'String' do |ss|
    ss.source_files = 'Utility/Source/String/*.swift'
    ss.dependency 'Utility/Core'
  end

  s.subspec 'UI' do |ss|
    ss.source_files = 'Utility/Source/UI/**/*.swift'
  end

  s.subspec 'UIExtension' do |ss|
    ss.source_files = 'Utility/Source/UIExtension/*.swift'
  end

end
