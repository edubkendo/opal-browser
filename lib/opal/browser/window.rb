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
	def self.document
    Document(`window.document`)
	end

	def self.puts (*what)
		what.each {|what|
			`window.console.log(what);`
		}
	end

	def self.alert (text)
		`window.alert(text)`
	end
end

module Kernel
	def alert (text)
		Window.alert(text)
	end
end

require 'opal/browser/document'

$document = Window.document
