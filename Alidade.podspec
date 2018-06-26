Pod::Spec.new do |s|
  s.name         = "Alidade"
  s.version      = "0.2.0"
  s.summary      = "Utility components"

  s.homepage     = "https://github.com/netcosports/Alidade"
  s.license      = { :type => "MIT" }
  s.author = { 
    'Dmitry Duleba' => 'dmitry.duleba@netcosports.com'
  }
  s.source       = { :git => "https://github.com/netcosports/Alidade.git", :tag => s.version.to_s }
  s.framework = ["UIKit", "Foundation"]

  s.ios.deployment_target = "9.0"
  
  s.default_subspec = 'Default'

  s.subspec 'Default' do |ss|
    ss.dependency 'Alidade/Core'
    ss.dependency 'Alidade/FormatterPool'
    ss.dependency 'Alidade/Vectors'
    ss.dependency 'Alidade/String'
    ss.dependency 'Alidade/UI'
    ss.dependency 'Alidade/UIExtension'
  end

  s.subspec 'Core' do |ss|
    ss.source_files = 'Alidade/Source/Core/*.swift'
  end

  s.subspec 'Geometry' do |ss|
    ss.dependency 'Alidade/Core'
    ss.dependency 'Alidade/Vectors'
    ss.source_files = 'Alidade/Source/Geometry/*.swift'
  end

  s.subspec 'Vectors' do |ss|
    ss.source_files = 'Alidade/Source/Vectors/*.swift'
    # ss.dependency 'Interpolate'
  end

  s.subspec 'String' do |ss|
    ss.dependency 'Alidade/Core'
    ss.source_files = 'Alidade/Source/String/*.swift'
  end

  s.subspec 'UI' do |ss|
    ss.dependency 'Alidade/Core'
    ss.source_files = 'Alidade/Source/UI/**/*.swift'
  end

  s.subspec 'UIExtension' do |ss|
    ss.source_files = 'Alidade/Source/UIExtension/*.swift'
  end

  # Other

  s.subspec 'Associatable' do |ss|
    ss.dependency 'Alidade/Boxed'
    ss.framework = ["ObjectiveC"]
    ss.source_files = 'Alidade/Source/Other/Associatable.swift'
  end

  s.subspec 'Boxed' do |ss|
    ss.source_files = 'Alidade/Source/Other/Boxed.swift'
  end

  s.subspec 'Flowable' do |ss|
    ss.source_files = 'Alidade/Source/Other/Flowable.swift'
  end

  s.subspec 'FormatterPool' do |ss|
    ss.source_files = 'Alidade/Source/Other/FormatterPool.swift'
  end

end
