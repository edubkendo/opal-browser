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

class Timeout
	include Native

	attr_reader :after

	def initialize (window, time, &block)
		@window = window
		@after  = time
		@block  = block

		super(`#@window.setTimeout(#{block.to_native}, time * 1000)`)
	end

	def abort
		`#@window.clearTimeout(#@native)`
	end

	alias stop abort
end

end; end
