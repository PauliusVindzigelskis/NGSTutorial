#
# Be sure to run `pod lib lint NGSTutorial.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NGSTutorial'
  s.version          = '1.0.1'
  s.summary          = 'Tutorial Controller'

  s.description      = 'Framework to build interactive tutorials'

  s.homepage         = 'https://github.com/PauliusVindzigelskis/NGSTutorial'
  s.screenshot       = 'https://user-images.githubusercontent.com/2383901/33856667-70c34d46-de8e-11e7-9ece-945037ca00de.gif'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Paulius Vindzigelskis' => 'p.vindzigelskis@gmail.com' }
  s.source           = { :git => 'https://github.com/PauliusVindzigelskis/NGSTutorial.git', :tag => "R1.0/#{s.version}" }

  s.ios.deployment_target = '9.0'

  s.source_files = 'Library/**/*.{h,m}'
  s.public_header_files = 'Library/**/*.h'
  s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'JMHoledView'
  s.dependency 'Masonry'
end
