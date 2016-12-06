Pod::Spec.new do |s|
  s.name             = 'WOWRibbonView'
  s.version          = '0.1.1'
  s.summary          = 'Ribbon view for iOS in Swift 3.'

  s.description      = <<-DESC
Ribbon view for iOS in Swift 3. Configurable for different types.
                       DESC

  s.homepage         = 'https://github.com/zhouhao27/WOWRibbonView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Zhou Hao' => 'zhou.hao.27@gmail.com' }
  s.source           = { :git => 'https://github.com/zhouhao27/WOWRibbonView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'WOWRibbonView/Classes/**/*'
end
