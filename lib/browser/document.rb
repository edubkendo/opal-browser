#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

require 'browser/document/element'

class << `Document`
	def xpath (path)
		root.xpath(path)
	end

	def css (path)
		root.css(path)
	end

	def root
		`self.native.documentElement`
	end

	def root= (element)
		`self.native.documentElement = element`
	end
end

Document = `document`

