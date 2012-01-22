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

class Keyboard < Event
	def alt?
		`#@native.altKey`
	end

	def ctrl?
		`#@native.ctrlKey`
	end

	def meta?
		`#@native.metaKey`
	end

	def shift?
		`#@native.shiftKey`
	end

	def code
		`#@native.keyCode || #@native.which`
	end

	alias to_i code
end

end; end; end
