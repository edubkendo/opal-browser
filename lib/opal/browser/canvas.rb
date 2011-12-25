#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

require 'opal/browser/canvas/context'

module Browser

class Canvas
	include SingleForwardable

	def initialize (element, context = '2d')
		@element = Element(element)
		@context = Context[context].new(@element)

		@context.methods.each {|name|
			def_delegators :@context, name unless respond_to? name
		}
	end
end

end
