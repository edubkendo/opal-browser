require 'bundler/setup'
require 'opal'

desc 'Build specified dependencies to build dir'
task :dependencies do
	Opal::DependencyBuilder.new(out: 'build').build
end

desc 'Build latest opal-browser to build dir'
task :build => :dependencies do
	Opal::Builder.new(files: 'lib', out: 'build/opal-browser.js').build
end

desc 'Build latest opal-browser ready for testing to build dir'
task :test => :dependencies do
	Opal::Builder.new(files: ['lib', 'spec'], debug: true, out: 'build/opal-browser.test.js').build
end

task :default => :build
