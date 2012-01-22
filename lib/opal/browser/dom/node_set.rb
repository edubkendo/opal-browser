#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

module Browser; module DOM

class NodeSet
	include Enumerable

	attr_reader :document

	def initialize (document, list = [])
		@document = document
		@internal = list
	end

	Enumerable.instance_methods.each {|name|
		define_method name do
			result = super

			Array === result ? NodeSet.new(document, result) : result
		end
	}

	def & (other)
		NodeSet.new(document, to_ary & other.to_ary)
	end

	def | (other)
		NodeSet.new(document, to_ary | other.to_ary)
	end

	def + (other)
		NodeSet.new(document, to_ary + other.to_ary)
	end

	def - (other)
		NodeSet.new(document, to_ary - other.to_ary)
	end

	def [] (*args)
		result = @internal[*args]

		Array === result ? NodeSet.new(document, result) : result
	end

	def add_class (name)
		each { |e| e.add_class(name) }
	end

	def after (node)
		last.after node
	end

	def at (path)
		raise NotImplementedError
	end

	def at_css (*rules)
		raise NotImplementedError
	end

	def at_xpath (*paths)
		raise NotImplementedError
	end

	def attr (key, value = nil, &block)
		unless Hash === key || key && (value || block)
			return first.attribute(key)
		end

		hash = Hash === key ? key : { key => value }

		hash.each { |k, v| each { |el| el[k] = v || block.call(el) } }

		self
	end

	alias attribute attr

	def before
		first.before
	end

	def children
		result = NodeSet.new(document)

		each { |n| result.concat(n.children) }

		result
	end

	def concat (other)
		@internal.concat(other.to_ary)

		self
	end

	def css (*paths)
		raise NotImplementedError
	end

	def delete (node)
		@internal.delete(node)
	end

	def dup
		NodeSet.new(document, to_ary.dup)
	end

	def each
		@internal.each { |n| yield n }

		self
	end

	def empty?
		@internal.empty?
	end

	def filter (expression)
		NodeSet.new(document, @internal.select { |node| node.matches?(expression) })
	end

	def first (*args)
		@internal.first(*args)
	end

	def include? (node)
		@internal.include?(node)
	end

	def index (node)
		@internal.index(node)
	end

	def inner_html (*args)
		map { |n| n.inner_html(*args) }.join
	end

	def inner_text
		map { |n| n.inner_text }.join
	end

	def last (*args)
		@internal.last(*args)
	end

	def length
		@internal.length
	end

	def pop
		@internal.pop
	end

	def push (node)
		@internal.push node
	end

	def remove
		raise NotImplementedError
	end

	def remove_attr (name)
		each { |n| n.remove_attr(name) }
	end

	def remove_class (name = nil)
		each { |n| n.remove_class(name) }
	end

	def reverse
		NodeSet.new(document, @internal.reverse)
	end

	def search (*what)
		map { |n| n.search(*what) }.flatten.uniq
	end

	def set (*)
		raise NotImplementedError
	end

	def shift
		@internal.shift
	end

	alias size length

	def slice (*args)
		@internal.slice(*args)
	end

	def text
		to_a.map { |n| n.text }.join
	end

	def to_a
		@internal
	end

	alias to_ary to_a

	# event related stuff

	def on (*args, &block)
		each { |n| n.on(*args, &block) }
	end

	def avoid (*args)
		each { |n| n.avoid(*args) }
	end

	def fire (*args)
		each { |n| n.fire(*args) }
	end
end

end; end
