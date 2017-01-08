# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','trellist','version.rb'])
spec = Gem::Specification.new do |s|
  s.name = 'trellist'
  s.version = Trellist::VERSION
  s.author = 'Chase Southard'
  s.email = 'chase.southard@gmail.com'
  s.homepage = ''
  s.platform = Gem::Platform::RUBY
  s.summary = 'A description of your project'
  s.files = `git ls-files`.split("")
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','trellist.rdoc']
  s.rdoc_options << '--title' << 'trellist' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'trellist'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_runtime_dependency('gli','2.14.0')
  s.add_runtime_dependency('ruby-trello','1.6.0')
end
