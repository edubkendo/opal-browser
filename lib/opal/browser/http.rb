#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

require 'require/extra'

require 'opal/browser/http/binary'
require 'opal/browser/http/headers'
require 'opal/browser/http/parameters'
require 'opal/browser/http/request'
require 'opal/browser/http/response'

module Browser

module HTTP
	def self.get (url, &block)
		Request.open(:get, url, &block)
	end

	def self.head (url, &block)
		Request.open(:head, url, &block)
	end

	def self.post (url, &block)
		Request.open(:post, url, &block)
	end
end

end

require 'opal/browser/http/file'
