Pod::Spec.new do |s|
  s.name         = "JiveSDK"
  s.version      = "0.0.1"
  s.license      = "Apache License, Version 2.0"
  s.summary      = "Jive API Wrapper for iOS/Mac."
  s.author       = { "Jive Mobile" => "jive-mobile@jivesoftware.com" }
  s.source       = { :git => "https://github.com/octiplex/jive-ios-sdk.git" }
  s.homepage     = "http://www.jivesoftware.com"

  s.ios.deployment_target = '6.0'
  s.osx.deployment_target = '10.7'

  s.source_files = 'jive-ios-sdk/**/*.{h,m}', 'lib/**/*.{h,m}'
  s.public_header_files = 'jive-ios-sdk/**/*.h'

  s.requires_arc = true

  s.dependency 'AFNetworking', '~> 1.2.0'
end