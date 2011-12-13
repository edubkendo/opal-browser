#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

require 'opal/browser/location'
require 'opal/browser/document/event'
require 'opal/browser/document/node'
require 'opal/browser/document/element'

module Browser

class Document
	include Node

	def initialize (native)
		@native = native
	end

	def root
		Element.new(`#@native.documentElement`)
	end

	def root= (element)
		`#@native.documentElement = #{element.to_native}`
	end

	def [] (what)
		`
			var result = #@native.getElementById(what);

			if (result) {
				return #{Element.new(`result`)};
			}
		`
		
		xpath(what).first || css(what).first
	end

	def location
		Location.new(`#@native.location`) unless Opal.undefined?(`#@native.location`)
	end

	def to_native
		@native
	end
end

end
