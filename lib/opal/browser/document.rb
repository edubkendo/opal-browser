#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

require 'opal/browser/document/element'

class Document
	extend Forwardable

	def_delegators :root, :xpath, :css, :on, :fire
	attr_reader    :native

	def initialize (native)
		@native = native
	end

	def root
		`#@native.documentElement`
	end

	def root= (element)
		`#@native.documentElement = element`
	end
end

module Kernel
	def Document (what)
		Document.new(what)
	end
end
