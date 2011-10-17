#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class << `window`
	def self.document
    Document
	end

	def self.puts (*what)
		what.each {|what|
			`self.console.log(what);`
		}
	end

	def self.alert (text)
		`self.alert(text)`
	end
end

Window = `window`

module Kernel
	def alert (text)
		Window.alert(text)
	end
end

require 'browser/document'
