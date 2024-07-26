Pod::Spec.new do |s|
  s.name             = 'live_chat_plus'
  s.version          = '1.0.0'
  s.summary          = 'A Flutter plugin to bring LiveChat functionality to Flutter'
  s.description      = <<-DESC
A Flutter plugin to bring LiveChat functionality to Flutter.
                       DESC
  s.homepage         = 'https://github.com/deriv-com/live-chat'
  s.license          = { :file => '../LICENSE' }
  s.author           = 'Deriv'
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'LiveChat', '~> 2.0.24'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
