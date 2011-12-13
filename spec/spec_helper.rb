require 'opal/spec/autorun'
require 'opal/browser'

if $0 == __FILE__
	Dir['spec/**/*.rb'].each { |spec| require spec }
end
