Gem::Specification.new {|s|
	s.name         = 'opal-browser'
	s.version      = '0.0.1'
	s.author       = ['meh.', 'Adam Beynon']
	s.email        = ['meh@paranoici.org', 'adam@adambeynon.com']
	s.homepage     = 'http://github.com/opal/opal-browser'
	s.platform     = Gem::Platform::RUBY
	s.summary      = 'Opal support for browser capabilities.'

	s.files         = `git ls-files`.split("\n")
	s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
	s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
	s.require_paths = ['lib']

	s.add_dependency 'opal-json'
	s.add_dependency 'call-me'
}
