#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Document

class Element
	include Node

	def initialize (native)
		@native = native
	end

	def children
		Array(`#@native.children`).map { |e| Element.new(e) }
	end

	def [] (name)
		`#@native.getAttribute(#{name.to_s})`
	end

	def []= (name, value)
		`#@native.setAttribute(#{name.to_s}, #{value.to_s})`
	end

	def attributes
		Hash[Array(`#@native.attributes`).map {|attr|
			[`attr.name`, `attr.value`]
		}]
	end

	def keys
		attributes.keys
	end

	def values
		attributes.values
	end

	def inspect
		"#<Document::Element(#{name}): #{children.inspect}>"
	end

	def to_native
		@native
	end
end

end
