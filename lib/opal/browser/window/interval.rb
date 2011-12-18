#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

module Browser; class Window

class Interval
	include Native

	attr_reader :every

	def initialize (window, time, &block)
		@window = window
		@every  = time
		@block  = block

		super(`#@window.setInterval(#{block.to_native}, time * 1000`)
	end

	def abort
		`#@window.clearInterval(#@native)`
	end

	alias stop abort
end

end; end
