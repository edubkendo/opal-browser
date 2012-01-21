Gem::Specification.new {|s|
	s.name         = 'opal-browser'
	s.version      = '0.0.1a1'
	s.author       = 'meh.'
	s.email        = 'meh@paranoici.org'
	s.homepage     = 'http://github.com/opal/opal-browser'
	s.platform     = Gem::Platform::RUBY
	s.summary      = 'Opal support for browser capabilities.'

	s.files         = `git ls-files`.split("\n")
	s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
	s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
	s.require_paths = ['lib']

	s.add_dependency 'require-extra'

	s.add_dependency 'opal-native'
	s.add_dependency 'opal-forwardable'
	s.add_dependency 'opal-json'

	s.add_dependency 'opal-spec'
}
