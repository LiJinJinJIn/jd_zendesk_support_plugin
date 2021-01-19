#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint jd_zendesk_support_plugin.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'jd_zendesk_support_plugin'
  s.version          = '0.0.1'
  s.summary          = 'Only contains the plugin library of zendesk helpcenter'
  s.description      = <<-DESC
Only contains the plugin library of zendesk helpcenter
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'lixin' => '15901384510@163.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
  s.dependency 'ZendeskSupportSDK', '5.1.0'
end
