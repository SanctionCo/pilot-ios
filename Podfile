platform :ios, '11.0'
use_frameworks!

target 'pilot' do
  pod 'SwiftHash', git: 'https://github.com/onmyway133/SwiftHash'
  pod 'Alamofire', '~> 4.5.0'
  pod 'ObjectMapper', '~> 3.0'
  pod 'AlamofireObjectMapper', '~> 5.0.0'
  pod 'HTTPStatusCodes', '~> 3.1.2'
  pod 'Locksmith', '~> 4.0.0'
  pod 'ImagePicker', '~> 3.0.0'
  pod 'Gallery', '~> 2.0.6'

  target 'pilotTests' do
    inherit! :search_paths

    pod 'Quick', '~> 1.2.0'
    pod 'Nimble', '~> 7.0.2'
  end

  target 'pilotUITests' do
    inherit! :search_paths

    pod 'Quick', '~> 1.2.0'
    pod 'Nimble', '~> 7.0.2'
  end
end
