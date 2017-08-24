Pod::Spec.new do |s|
  s.name             = 'Essence'
  s.version          = '1.0.1'
  s.summary          = 'The Essence of your iOS device.'

  s.homepage         = 'https://github.com/Meniny/Essence'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Andrea Mario Lufino' => 'andrea.lufino@me.com' }
  s.source           = { :git => 'https://github.com/Meniny/Essence.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Essence/**/*'
  s.public_header_files = 'Essence/**/*.h'
  s.frameworks = 'UIKit', 'SystemConfiguration', 'CoreTelephony', 'AVFoundation', 'ExternalAccessory'
end
