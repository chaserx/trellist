# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','trellist','version.rb'])
spec = Gem::Specification.new do |s|
  s.name = 'trellist'
  s.version = Trellist::VERSION
  s.author = 'Chase Southard'
  s.email = 'chase.southard@gmail.com'
  s.homepage = 'https://github.com/chaserx/trellist'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Retrieve Trello lists and list cards. Capture card data in various useful formats.'
  s.files = `git ls-files`.split(" ")
  s.license = 'MIT'
  s.post_install_message = "You can install config file: `trellist initconfig` \n then update your ~/.trellist with Trello credentials"
  s.require_paths << 'lib'
  s.bindir = 'bin'
  s.executables << 'trellist'
  s.required_ruby_version = '>= 2.3.0'

  s.add_development_dependency('rake', '12.0.0')
  s.add_development_dependency('rdoc', '5.0.0')
  s.add_development_dependency('aruba', '0.14.2')
  s.add_development_dependency('rspec', '3.5.0')
  s.add_development_dependency('vcr', '3.0.3')
  s.add_development_dependency('webmock', '2.3.2')
  s.add_runtime_dependency('gli','2.14.0')
  s.add_runtime_dependency('ruby-trello','1.6.0')
  s.add_runtime_dependency('highline','1.7.8')
  s.add_runtime_dependency('paint','2.0.0')
end
