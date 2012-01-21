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
		request = new &block

		request.open(method, url)
		request.send
	end

	include Native

	attr_reader   :data, :headers
	attr_accessor :method, :url, :asynchronous, :user, :password

	def initialize (&block)
		super(`new XMLHttpRequest()`)

		@headers = Headers.new

		@method       = :GET
		@asynchronous = true

		instance_eval &block
	end

	def asynchronous?; @asynchronous;  end
	def synchronous?;  !@asynchronous; end
	
	def asynchronous!; @asynchronous = true;  end
	def synchronous!;  @asynchronous = false; end

	def binary?; @binary; end
	def binary!
		unless required? 'typed-array'
			raise NotImplementedError, 'you have to require typed-array to work on binary files'
		end

		@binary = true
	end

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

		raise 'the request has already been sent' if sent?

		@headers.each {|name, value|
			`#@native.setRequestHeader(#{name.to_str}, #{value.to_str})`
		}

		`#@native.responseType = 'arraybuffer'` if binary?

		`#@native.send(#{data || @parameters ? Parameters[data || @parameters].to_str : `null`})`

		sent!

		Response.new(self)
	end

	def abort
		`#@native.abort()`
	end
end

end; end
