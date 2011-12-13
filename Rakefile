require 'bundler/setup'
require 'opal'
require 'opal/builder_task'

Opal::BuilderTask.new do |t|
	# this is the default, but have it here for clarity
	t.files = Dir['lib/**/*.rb']

	# test configuration
	t.config :test do
		# always include the runtime
		#t.runtime = true

		# different output to save overwriting main config
		t.out = 'opal-browser.test.js'

		# for tests, we MUST include spec/ dir as well..
		t.files = Dir['{lib,spec}/**/*.rb']

		# our main (entry point) file should be our spec_helper, which runs our tests
		t.main = 'spec/spec_helper.rb'
	end
end
