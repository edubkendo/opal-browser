#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

module Browser

class Location
	include Native

	attr_accessor_bridge :@native, :hash, :host, :hostname, :href, :pathname, :port, :protocol, :search

	def assign (url)
		`#@native.assign(#{url.to_s})`
	end

	def reload (force = false)
		`#@native.reload(force)`
	end

	def replace (url)
		`#@native.replace(#{url.to_s})`
	end

	def to_s
		`#@native.toString()`
	end
end

end
