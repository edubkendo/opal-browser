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
		Document.from_native(`window.document`)
	end

	def self.puts (*what)
		what.each {|what|
			`console.log(what);`
		}

		nil
	end
end

require 'browser/document'
