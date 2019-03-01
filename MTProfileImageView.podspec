#
# Be sure to run `pod lib lint MTProfileImageView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MTProfileImageView'
  s.version          = '0.2.6'
  s.summary          = 'UIImageView subclass which either shows image from imageURLm OR creates 2 character name based image for profile'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: UIImageView subclass which either shows image from imageURLm OR creates 2 character name based image for profile.
                       DESC
                       
  s.homepage         = 'https://github.com/Mehul18292/MTProfileImageView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mehul Thakkar' => 'mehul18292@gmail.com' }
  s.source           = { :git => 'https://github.com/Mehul18292/MTProfileImageView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MTProfileImageView/*'
  s.swift_version = '4.2'
  
  # s.resource_bundles = {
  #   'MTProfileImageView' => ['MTProfileImageView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SDWebImage'
end
