#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

module Browser; module HTTP

class Request
	def self.open (method, url, &block)
		request = new
		request.instance_eval &block

		request.open(method, url)
		request.send
	end

	include Native

	attr_reader   :data, :headers
	attr_accessor :method, :url, :asynchronous, :user, :password

	alias asynchronous? asynchronous

	def initialize (&block)
		super(`new XMLHttpRequest()`)

		@headers = Headers.new

		@method       = :GET
		@asynchronous = true
	end

	def binary?; @binary; end
	def binary!; @binary = true; end

	def opened?; @opened; end
	def opened!; @opened = true; end

	def sent?; @sent; end
	def sent!; @sent = true; end

	def open (method = nil, url = nil, asynchronous = nil, user = nil, password = nil)
		raise 'the request has already been opened' if opened?

		@method       = method       if method
		@url          = url          if url
		@asynchronous = asynchronous if asynchronous
		@user         = user         if user
		@password     = password     if password

		`#@native.open(#{@method.to_s}, #{@url.to_s}, #{@asynchronous.to_native}, #{@user.to_native}, #{@password.to_native})`

		opened!

		self
	end

	def send (data = nil)
		raise 'the request has not been opened' unless opened?

		return if sent?

		@headers.each {|name, value|
			`#@native.setRequestHeader(#{name.to_str}, #{value.to_str})`
		}

		`#@native.responseType = 'arraybuffer'` if binary?

		`#@native.send(#{Parameters[data || @parameters].to_str})`

		sent!

		Response.new(self)
	end

	def abort
		`#@native.abort()`
	end
end

end; end
