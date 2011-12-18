#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class String
	def encodeURIComponent
		`encodeURIComponent(self)`
	end

	def encodeURI
		`encodeURI(self)`
	end

	def decodeURIComponent
		`decodeURIComponent(self)`
	end

	def decodeURI
		`decodeURI(self)`
	end
end
