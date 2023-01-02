Pod::Spec.new do |s|
  s.name             = 'IMQAMPMAgent'
  version            = '3.18.0'
  s.version          = version
  s.summary          = 'Crash Report SDK for iOS by IMQA'

  s.description      = 'This Framework is MPM SDK for iOS by IMQA'

  s.homepage         = 'http://imqa.io/'
  s.license          = { :type => 'Commercial', :file => 'IMQAMPMAgent.xcframework/ios-arm64/IMQAMPMAgent.framework/LICENSE' }
  s.author           = { 'Onycom, Inc.' => 'support@imqa.io' }
  s.source           = { :http  => "https://github.com/onycom-imqa/IMQA-MPM-Release/releases/download/v#{s.version}/IMQAMPMAgent.zip" }

  s.ios.deployment_target = '9.0'
  
  s.ios.vendored_frameworks = 'IMQAMPMAgent.xcframework'

  s.pod_target_xcconfig = { 'VALID_ARCHS' => 'arm64 arm64e armv7 armv7s x86_64' }
end
