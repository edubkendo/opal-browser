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

module Browser
	def self.engine
		`/MSIE/WebKit|Presto|Gecko/.exec(navigator.userAgent)[0]`.downcase.to_sym
	rescue
		:unknown
	end
end

require 'opal/browser/window'
