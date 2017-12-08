#
# Be sure to run `pod lib lint NGSTutorial.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NGSTutorial'
  s.version          = '0.1.0'
  s.summary          = 'Tutorial Controller'

  s.description      = 'Framework to build interactive tutorials'

  s.homepage         = 'https://github.com/Paulius Vindzigelskis/NGSTutorial'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Paulius Vindzigelskis' => 'p.vindzigelskis@gmail.com' }
  s.source           = { :git => 'https://github.com/Paulius Vindzigelskis/NGSTutorial.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'Library/**/*.{h,m}'
  s.public_header_files = 'Library/**/*.h'
  s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'JMHoledView'
  s.dependency 'Masonry'
end