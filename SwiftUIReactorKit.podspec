Pod::Spec.new do |s|
  s.name             = "SwiftUIReactorKit"
  s.version          = "0.0.4"
  s.summary          = "An extension of devxoul's ReactorKit, specifically designed to work with SwiftUI"
  s.homepage         = "https://github.com/gunoooo/ReactorKit-SwiftUI"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "박건우(Ethen)" => "rjsdnqkr1@naver.com" }
  s.source           = { :git => "https://github.com/gunoooo/ReactorKit-SwiftUI.git", :tag => s.version.to_s }
  s.source_files = "Sources/**/*.swift"
  s.frameworks   = "Foundation"
  s.swift_version = "5.0"
  s.dependency "ReactorKit", "~> 3.0"

  s.ios.deployment_target = "13.0"
  s.osx.deployment_target = "10.15"
  s.tvos.deployment_target = "13.0"
  s.watchos.deployment_target = "6.0"
end
