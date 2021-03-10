Pod::Spec.new do |s|
  s.name             = 'IMQAMpm'
  version            = 'IMQAVERSION'
  s.version          = version
  s.summary          = 'Crash Report SDK for iOS by IMQA'

  s.description      = 'This Framework is MPM SDK for iOS by IMQA'

  s.homepage         = 'http://imqa.io/'
  s.license          = { :type => 'Commercial', :file => 'IMQAMpm.xcframework/ios-arm64_armv7/IMQAMpm.framework/LICENSE' }
  s.author           = { 'Onycom, Inc.' => 'support@imqa.io' }
  s.source           = { :http  => "https://github.com/onycom-imqa/IMQA-MPM-Release/releases/download/v#{s.version}/IMQAMpm.zip" }

  s.ios.deployment_target = '9.0'
  
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

  s.vendored_frameworks = 'IMQAMpm.xcframework'
end
