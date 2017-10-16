Pod::Spec.new do |s|

  s.name         = "Utility"
  s.version      = "0.1.0"
  s.license      = { :type => "GNU", :file => "LICENSE.md" }
  s.summary      = "Different utility components"
  s.homepage     = "https://github.com/dDomovoj/Utility"
  s.author       = "dDomovoj"
  s.source       = { :git => "https://github.com/dDomovoj/Utility.git", :tag => s.version }

  s.ios.deployment_target = "8.0"

  s.subspec 'Core' do |ss|
    ss.source_files = 'Utility/Source/Core/*.swift'
  end

  s.subspec 'UI' do |ss|
    ss.source_files = 'Utility/Source/UI/**/.swift'
  end

  s.subspec 'Debug' do |ss|
    ss.source_files = 'Utility/Source/Debug/*.swift'
  end

  s.subspec 'FormatterPool' do |ss|
    ss.source_files = 'Utility/Source/FormatterPool/*.swift'
  end
  # s.module_name  = "Utility"
end
