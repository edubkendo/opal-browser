#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Window
	def document
    Document(`#@native.document`)
	end

	def puts (*what)
		what.each {|what|
			`#@native.console.log(what);`
		}
	end

	def alert (text)
		`#@native.alert(text)`
	end
end

module Kernel
	def Window (what)
		Window.new(what)
	end
end

require 'opal/browser/document'

$window   = Window(`window`)
$document = $window.document

module Kernel
	def alert (text)
		$window.alert(text)
	end
end
