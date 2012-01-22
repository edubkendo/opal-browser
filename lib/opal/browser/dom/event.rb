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

class Event
	Normalization = {
		load:  'DOMContentLoaded',
		hover: 'mouseover'
	}

	def self.normalize (name)
		Normalization[name] || name
	end

	include Native

	def self.from_native (value)
		%x{
			if (value instanceof MouseEvent) {
				return #{Mouse.new(value)};
			}
			else if (value instanceof KeyboardEvent) {
				return #{Keyboard.new(value)};
			}
			else if (value instanceof MutationEvent) {
				return #{Mutation.new(value)};
			}
			else {
				return #{Event.new(value)};
			}
		}
	end

	def name
		`#@native.eventName`
	end

	def data
		`#@native.data`
	end

	def stopped?; !!@stopped; end

	def stop!
		@stopped = true
	end
end

end; end

require 'opal/browser/dom/event/mouse'
require 'opal/browser/dom/event/keyboard'
require 'opal/browser/dom/event/mutation'
