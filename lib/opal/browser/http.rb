#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

module Browser

require 'typed_array'

require 'opal/browser/http/headers'
require 'opal/browser/http/parameters'
require 'opal/browser/http/request'
require 'opal/browser/http/response'

module HTTP
	def self.get (url, &block)
		Request.open('GET', url, &block)
	end

	def self.head (url, &block)
		Request.open('HEAD', url, &block)
	end

	def self.post (url, &block)
		Request.open('POST', url, &block)
	end
end

end
