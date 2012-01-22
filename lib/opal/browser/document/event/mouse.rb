#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

module Browser; class Document; class Event

class Mouse < Event
	Position = Struct.new(:x, :y)

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

	def button
		`#@native.button`
	end

	def client
		Position.new(`#@native.clientX`, `#@native.clientY`)
	end

	def layer
		Position.new(`#@native.layerX`, `#@native.layerY`) # if defined? `#@native.layerX`
	end

	def offset
		Position.new(`#@native.offsetX`, `#@native.offsetY`) # if defined? `#@native.offsetX`
	end

	def page
		Position.new(`#@native.pageX`, `#@native.pageY`) # if defined? `#@native.pageX`
	end

	def screen
		Position.new(`#@native.screenX`, `#@native.screenY`) # if defined? `#@native.screenX`
	end

	def ancestor
		Position.new(`#@native.x`, `#@native.y`) # if defined? `#@native.x`
	end

	def x
		screen.x
	end

	def y
		screen.y
	end

	def target
		`#@native.relatedTarget`
	end

	def from
		Element(`#@native.fromElement`)
	end

	def to
		Element(`#@native.toElement`)
	end
end

end; end; end
