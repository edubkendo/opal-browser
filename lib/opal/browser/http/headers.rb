#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

module Browser; module HTTP

class Header
	attr_reader :name, :value

	def initialize (name, value)
		@name  = name
		@value = value
	end

	def to_s
		@value
	end

	alias to_str to_s
end

class Headers < Hash
	def self.parse (string)
		self[string.lines.map { |l| l.chomp.split(/\s*:\s*/) }]
	end

	def []= (name, value)
		super(name, value.is_a?(Header) ? value : Header.new(name, value))
	end

	def merge! (other)
		other.each {|name, value|
			self[name] = value
		}
	end
end

end; end
