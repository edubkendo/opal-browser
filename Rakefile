require 'rake'
require 'opal/bundle_task'

task :default => ['opal:install', 'opal:test']

Opal::BundleTask.new do |t|
  # this is the default, but have it here for clarity
  t.files = FileList['lib/**/*.rb']
	t.stdlib = %w[rbconfig optparse forwardable]

  # test configuration
  t.config :test do
		# always include the runtime
		t.runtime = true

    # different output to save overwriting main config
    t.out = 'opal-browser.test.js'

    # for tests, we MUST include spec/ dir as well..
    t.files = FileList['{lib,spec}/**/*.rb']

    # we also rely on opaltest for actually doign the tests
    t.gem 'opaltest', git: 'git://github.com/adambeynon/opaltest.git'

    # our main (entry point) file should be our spec_helper, which runs our tests
    t.main = 'spec/spec_helper.rb'
  end
end
