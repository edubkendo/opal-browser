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

class << Document
	extend Forwardable

	def_delegators :root, :xpath, :css, :on, :fire

	def root
		`self.documentElement`
	end

	def root= (element)
		`self.documentElement = element`
	end
end

module Kernel
	def Document (what)
		Document.from_native(what)
	end
end
