#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

require 'forwardable'
require 'native'
require 'json'

module Browser
	def self.engine
		`/MSIE|WebKit|Presto|Gecko/.exec(navigator.userAgent)[0]`.downcase
	rescue
		:unknown
	end
end

require 'opal/browser/utils'
require 'opal/browser/window'
require 'opal/browser/http'
