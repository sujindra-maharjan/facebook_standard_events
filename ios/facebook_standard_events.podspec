#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'facebook_standard_events'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin for Facebook Standard Events'
  s.description      = <<-DESC
A new Flutter plugin for Facebook Standard Events
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Hallo Team' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'FBSDKCoreKit', '~> 5.0'

  s.ios.deployment_target = '8.0'
end

