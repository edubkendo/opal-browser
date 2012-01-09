require 'bundler/setup'
require 'opal'

desc 'Build specified dependencies into build/'
task :dependencies do
	Opal::DependencyBuilder.new(dependencies: %w[call-me opal-spec], out: 'build').build
end

desc 'Build latest opal-browser to build/'
task :browser do
	Opal::Builder.new('lib', join: 'build/opal-browser.js').build
end

desc 'Build latest opal-browser ready for testing in build/'
task :test do
	Opal::Builder.new(['lib', 'spec'], debug: true, join: 'build/opal-browser.test.js').build
end

task :default => :browser
