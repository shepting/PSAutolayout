Pod::Spec.new do |s|
  s.name         = 'PSAutolayout'
  s.version      = '1.0'
  s.license      = { :type => 'Apache', :file => 'LICENSE' }
  s.homepage     = 'https://github.com/shepting/PSAutolayout'
  s.author       =  {'Steven Hepting' => 'shepting@gmail.com' }
  s.summary      = 'Autolayout utility for source-based layout code.'
  s.source       =  {:git => 'https://github.com/shepting/PSAutolayout.git', :tag => 'v1.0' }
  s.source_files = 'Source/*'
  s.requires_arc = true
  s.platform     = :ios, '8.0'
end
