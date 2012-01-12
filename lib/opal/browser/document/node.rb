#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

module Browser; class Document

module Node
	include Native

	def == (other)
		`#@native === #{other.to_native}`
	end

	def hash
		%x{
			if (#@native.$id) {
				return #@native.$id;
			}

			return #@native.$id = rb_hash_yield++;
		}
	end

	def name
		`#@native.nodeName`
	end

	def value
		`#@native.nodeValue`
	end

	def document
		Document.new(`#@native.ownerDocument`)
	end

	def root
		document.root
	end

	def parent
		Element.new(`#@native.parentNode`) unless Opal.undefined?(`#@native.parentNode`)
	end

	def xpath (path)
		result = []

		%x{
			var tmp = (#@native.ownerDocument || #@native.self).evaluate(
				path, #@native, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);

			for (var i = 0; i < tmp.snapshotLength; i++) {
				result.push(tmp.snapshotItem(i));
			}
		}

		result.map { |e| Element.new(e) }
	end

	def css (path)
		Array(`#@native.querySelectorAll(path)`).map { |e| Element.new(e) }
	end

	def search (what)
		(xpath(what) + css(what)).uniq
	end

	def on (what, capture = false, &block)
		raise ArgumentError, 'no block has been passed' unless block

		`#@native.addEventListener(#{Document::Event.normalize(what)}, function (event) { #{block.call(Element.new(`this`), Document::Event.new(event))} }, capture)`
	end

	def fire (what, data, bubble = false)
		%x{
			var event = document.createEvent('HTMLEvents');

			event.initEvent('dataavailable', bubble, true);
			event.eventName = what;
			event.data      = data;
			
			return self.dispatchEvent(event);
		}
	end
end

end; end
