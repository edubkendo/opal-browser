#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

module Browser; module DOM; class Event

class Mutation < Event
	def change
		%w[_ modification addition removal][`#@native.attrChange`]
	end

	def name
		`#@native.attrName`
	end

	def new
		`#@native.newValue`
	end

	def old
		`#@native.prevValue`
	end

	def node
		`#@native.relatedNode`
	end
end

end; end; end
