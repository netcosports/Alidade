Pod::Spec.new do |s|

  s.name         = "Utility"
  s.version      = "0.1.0"
  s.license      = { :type => "MIT", :file => "LICENSE.md" }
  s.summary      = "Utility components"
  s.homepage     = "https://github.com/dDomovoj/Utility"
  s.author       = "dDomovoj"
  s.source       = { :git => "https://github.com/dDomovoj/Utility.git", :tag => s.version }

  s.ios.deployment_target = "9.0"
  s.default_subspec = 'Core'

  s.subspec 'Core' do |ss|
    ss.source_files = 'Utility/Source/Core/*.swift'
  end

  s.subspec 'Operators' do |ss|
    ss.source_files = 'Utility/Source/Operators/*.swift'
  end

  s.subspec 'UIExtension' do |ss|
    ss.source_files = 'Utility/Source/UIExtension/*.swift'
  end

  s.subspec 'UI' do |ss|
    ss.source_files = 'Utility/Source/UI/**/*.swift'
  end

  s.subspec 'String' do |ss|
    ss.source_files = 'Utility/Source/String/*.swift'
  end

  s.subspec 'Formatter' do |ss|
    ss.source_files = 'Utility/Source/Formatter/*.swift'
  end

  # s.subspec 'Geometry' do |ss|
  #   ss.source_files = 'Utility/Geometry/UI/**/*.swift'
  # end
end
