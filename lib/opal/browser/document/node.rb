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

module Node
	def name
		`#@native.nodeName`
	end

	def value
		`#@native.nodeValue`
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

	def xpath (path)
		result = []

		`
			var tmp = (#@native.ownerDocument || #@native.self).evaluate(
				path, #@native, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);

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
		raise ArgumentError, 'no block has been passed' unless block

		`#@native.addEventListener(#{Document::Event.normalize(what)}, function (event) { #{block.call(Element(`this`), Document::Event.new(event))} }, capture)`
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
end

end
