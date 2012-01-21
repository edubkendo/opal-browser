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

class Binary
	include Native

	def initialize (*)
		super

		if String === @native
			@type = :string
			@data = @native
		else
			@type = :buffer
			@data = @native.to_a
		end
	end

	def [] (index)
		@type == :string ? `#@data.charCodeAt(index) & 0xff` : @data[index]
	end
end

end; end
