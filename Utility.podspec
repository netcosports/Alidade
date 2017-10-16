Pod::Spec.new do |s|

  s.name         = "Utility"
  s.version      = "0.1.0"
  s.summary      = "Different utility components"

  s.license      = { :type => "GNU", :file => "LICENSE.md" }
  s.author       = "dDomovoj"
  s.homepage     = "https://github.com/dDomovoj/Utility"

  s.ios.deployment_target = "8.0"

  s.source       = { :git => "https://github.com/dDomovoj/Utility.git", :tag => s.version }
  s.source_files = "Utility/Source/*.swift"
  s.module_name  = "Utility"

end
