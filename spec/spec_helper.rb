# Any help stuff in here..

require 'opaltest/spec'       # DSL for mspec style specs, on top of MiniTest
require 'opaltest/autorun'    # Autoloads.. ie: run tests

# make sure our lib is loaded
require 'browser'

##
# If this is the 'main' file, then load all specs found in spec/

if $0 == __FILE__
  Dir['spec/**/*.rb'].each { |spec| require spec }

  # currently a bug in opal; globs wont pick up single level down..
  Dir['spec/*.rb'].each { |spec| require spec }
end

