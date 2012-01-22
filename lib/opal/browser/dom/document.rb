#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

require 'opal/browser/location'

module Browser; module DOM

class Document < Node
	def [] (what)
		%x{
			var result = #@native.getElementById(what);

			if (result) {
				return #{DOM(`result`)};
			}
		}
		
		xpath(what).first || css(what).first
	end

	alias at []

	def cookies
		Cookies.new(to_native) #if defined? `#@native.cookie`
	end

	def inspect
		"#<DOM::Document: #{children.inspect}>"
	end

	def location
		Location.new(`#@native.location`) #if defined? `#@native.location`
	end

	def root
		DOM(`#@native.documentElement`)
	end

	def root= (element)
		`#@native.documentElement = #{element.to_native}`
	end
end

end; end
