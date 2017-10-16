Pod::Spec.new do |s|

  s.name         = "Utility"
  s.version      = "0.1.0"
  s.summary      = "Different utility components"

  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = "dDomovoj"

  s.ios.deployment_target = "8.0"

  s.source       = { :git => "https://github.com/ddomovoj/Utility.git", :tag => s.version }
  s.source_files = "Utility/*.swift"
  s.module_name  = "Utility"

end
