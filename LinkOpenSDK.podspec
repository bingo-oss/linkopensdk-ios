Pod::Spec.new do |s|

  s.name         = "LinkOpenSDK"
  s.version      = "1.0.0"
  s.summary      = "OpenSDK for Link."

  s.ios.deployment_target = '7.0'

  s.description  = <<-DESC
  OpenSDK for Bingo Link. 
                   DESC

  s.homepage     = "https://github.com/bingo-oss/linkopensdk-ios"

  s.license      = "Apache 2.0"

  s.author       = { 'linjc' => 'linjc@bingosoft.net' }

  s.source       = { :git => "https://github.com/bingo-oss/linkopensdk-ios.git", :tag => "#{s.version}" }

  s.source_files  = "src", "src/**/*.{h,m}"

  s.public_header_files = 'src/**/*.h'

  s.dependency 'AFNetworking', '~> 3.0'

end
