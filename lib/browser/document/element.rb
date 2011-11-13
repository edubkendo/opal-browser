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
	def name
		`self.nodeName`
	end

	def document
		Document(`self.ownerDocument`)
	end

	def root
		document.root
	end

	def parent
		`self.parentNode`
	end

	def children
		Array(`self.children`).map { |e| Element(e) }
	end

	def [] (name)
		`self.getAttribute(#{name.to_s})`
	end

	def []= (name, value)
		`self.setAttribute(#{name.to_s}, #{value.to_s})`
	end

	def attributes
		Hash[Array(`self.attributes`).map {|attr|
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
		Array(`self.querySelectorAll(path)`).map { |e| Element(e) }
	end

	def on (what, capture = false, &block)
		return unless block

		`self.addEventListener(what, function (event) { #{block.(Element(`this`), event)} }, capture)`
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
		Element.from_native(what)
	end
end
