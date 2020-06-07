Pod::Spec.new do |s|
  s.name             = 'DecodeValue'
  s.version          = '0.1.0'
  s.summary          = 'Help De(codable) parsing.'
  s.description      = <<-DESC
  Help De(codable) parsing
  DESC

  s.homepage         = 'https://github.com/outofcoding/DecodeValue'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'outofcoding' => 'outofcoding@gmail.com' }
  s.source           = { :git => 'https://github.com/outofcoding/DecodeValue.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'DecodeValue/Classes/**/*'
  s.dependency 'Optional.Extension'
end
