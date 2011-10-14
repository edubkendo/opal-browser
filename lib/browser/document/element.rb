#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class << `Element`
	def name
		`return self.native.nodeName`
	end

	def document
		Document.from_native(`self.native.ownerDocument`)
	end

	def root
		document.root
	end

	def parent
		`return self.native.parentNode`
	end

	def children

	end

	def [] (name)
		`return self.native.getAttribute(#{name.to_s})`
	end

	def []= (name, value)
		`self.native.setAttribute(#{name.to_s}, #{value.to_s})`
	end

	def attributes
		Hash[Array.from_native(`self.attributes`).map {|attribute|
			[`attribute.name`, `attribute.value`]
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
			var tmp    = (self.native.ownerDocument || self.native).evaluate(
				path, self.native, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);

			for (var i = 0; i < tmp.snapshotLength; i++) {
				result.push(tmp.snapshotItem(i));
			}

			return result;
		`
	end

	def css (path)
		`self.native.querySelectorAll(path)`
	end

	def to_s
		"#<Document::Element(#{name}): #{children}>"
	end
end
