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

class Event
	include Native

	Normalization = {
		load: 'DOMContentLoaded'
	}

	def self.normalize (name)
		Normalization[name.to_sym] || name.to_s
	end

	def name
		`#@native.eventName`
	end

	def data
		`#@native.data`
	end
end

end
