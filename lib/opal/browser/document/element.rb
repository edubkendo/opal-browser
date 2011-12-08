#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Element
	attr_reader :native

	def initialize (native)
		@native = native
	end

	def name
		`#@native.nodeName`
	end

	def document
		Document(`#@native.ownerDocument`)
	end

	def root
		document.root
	end

	def parent
		`#@native.parentNode`
	end

	def children
		Array(`#@native.children`).map { |e| Element(e) }
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

	def xpath (path)
		`
			var result = [];
			var tmp    = (self.ownerDocument || self).evaluate(
				path, self, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);

			for (var i = 0; i < tmp.snapshotLength; i++) {
				result.push(tmp.snapshotItem(i));
			}
		`

		result.map { |e| Element(e) }
	end

	def css (path)
		Array(`#@native.querySelectorAll(path)`).map { |e| Element(e) }
	end

	def on (what, capture = false, &block)
		return unless block

		`#@native.addEventListener(what, function (event) { #{block.call(Element(`this`), event)} }, capture)`
	end

	def fire (what, data, bubble = false)
		`
			var event = document.createEvent('HTMLEvents');

			event.initEvent('dataavailable', bubble, true);
			event.eventName = what;
			event.data      = data;
			
			return self.dispatchEvent(event);
		`
	end

	def to_s
		"#<Document::Element(#{name}): #{children}>"
	end
end

module Kernel
	def Element (what)
		Element.new(what)
	end
end
