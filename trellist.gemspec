# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','trellist','version.rb'])
spec = Gem::Specification.new do |s|
  s.name = 'trellist'
  s.version = Trellist::VERSION
  s.author = 'Chase Southard'
  s.email = 'chase.southard@gmail.com'
  s.homepage = 'https://github.com/chaserx/trellist'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Retrieve Trello list card data in various useful formats'
  s.files = `git ls-files`.split("")
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','trellist.rdoc']
  s.rdoc_options << '--title' << 'trellist' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'trellist'

  s.required_ruby_version = '>= 2.3.0'

  # TODO(chaserx): add post-install note to ask the user to run the config first

  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_runtime_dependency('gli','2.14.0')
  s.add_runtime_dependency('ruby-trello','1.6.0')
  s.add_runtime_dependency('highline','1.7.8')
  s.add_runtime_dependency('paint','2.0.0')
end
