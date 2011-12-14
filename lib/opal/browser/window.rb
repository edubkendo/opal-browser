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

module Browser

class Window
	include Native

	def document
    Document.new(`#@native.document`)
	end

	def puts (*what)
		what.each {|what|
			`#@native.console.log(what);`
		}
	end

	def alert (text)
		`#@native.alert(text)`
	end

	def location
		Location.new(`#@native.location`) unless Opal.undefined?(`#@native.location`)
	end

	def navigator
		Navigator.new(`#@native.navigator`) unless Opal.undefined?(`#@native.navigator`)
	end
end

end

require 'opal/browser/document'

$window   = Window.new(`window`)
$document = $window.document

module Kernel
	def alert (text)
		$window.alert(text)
	end
end
