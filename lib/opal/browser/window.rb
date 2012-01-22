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
require 'opal/browser/navigator'
require 'opal/browser/cookies'
require 'opal/browser/dom'

require 'opal/browser/window/interval'
require 'opal/browser/window/timeout'

module Browser

class Window
	include Native

	def alert (text)
		`#@native.alert(text)`
	end

	def location
		Location.new(`#@native.location`) unless Opal.undefined?(`#@native.location`)
	end

	def navigator
		Navigator.new(`#@native.navigator`) unless Opal.undefined?(`#@native.navigator`)
	end

	def document
		DOM(`#@native.document`)
	end

	def every (time, &block)
		Interval.new(to_native, time, &block)
	end

	def once (time, &block)
		Timeout.new(to_native, time, &block)
	end
	
	alias once_after once

	alias after once
end

end

$window   = Browser::Window.new(`window`)
$document = $window.document

module Kernel
	def Window (what)
		Browser::Window.new(Native.normalize(what))
	end

	def alert (text)
		$window.alert(text)
	end

	def log (what)
		`#{$window.to_native}.console.log(what)`
	end
end
