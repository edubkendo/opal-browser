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

	DefaultHeaders = Headers[{
		'X-Requested-With' => 'XMLHttpRequest',
#		'X-Opal-Version'   => Opal::VERSION,
		'Accept'           => 'text/javascript, text/html, application/xml, text/xml, */*'
	}]

	include Native

	attr_reader   :data, :headers, :response
	attr_accessor :method, :url, :asynchronous, :user, :password, :mime_type, :content_type, :encoding

	def initialize (&block)
		super(`new XMLHttpRequest()`)

		@headers      = Headers[DefaultHeaders]
		@method       = :get
		@asynchronous = true
		@cachable     = true
		@callbacks    = {}

		instance_eval &block
	end

	def asynchronous?; @asynchronous;  end
	def synchronous?;  !@asynchronous; end
	
	def asynchronous!; @asynchronous = true;  end
	def synchronous!;  @asynchronous = false; end

	def binary?; @binary;        end
	def binary!; @binary = true; end

	def cachable?; @cachable;         end
	def no_cache!; @cachable = false; end

	def opened?; @opened;        end
	def opened!; @opened = true; end

	def sent?; @sent;        end
	def sent!; @sent = true; end

	def completed?; @completed;        end
	def completed!; @completed = true; end

	def on (what, &block)
		@callbacks[what] = block
	end

	def callback
		proc {|event|
			state = %w[uninitialized loading loaded interactive complete][`#@native.readyState`]

			begin
				if state == :complete
					completed!

					@callbacks[response.status.code].(response) if @callbacks[response.status.code]
					
					if response.success?
						@callbacks[:success].(response) if @callbacks[:success]
					else
						@callbacks[:failure].(response) if @callbacks[:failure]
					end
				end

				@callbacks[state].(response) if @callbacks[state]
			rescue Exception => e
				@callbacks[:exception].(request, state, e) if @callbacks[:exception]
			end
		}.to_native
	end

	def open (method = nil, url = nil, asynchronous = nil, user = nil, password = nil)
		raise 'the request has already been opened' if opened?

		@method       = method       if method
		@url          = url          if url
		@asynchronous = asynchronous if asynchronous
		@user         = user         if user
		@password     = password     if password

		url = @url

		unless cachable?
			url += (url.include?('?') ? '&' : '?') + rand.to_s
		end

		`#@native.open(#{@method.upcase}, #{url}, #{@asynchronous.to_native}, #{@user.to_native}, #{@password.to_native})`

		opened!

		unless @callbacks.empty?
			`#@native.onreadystatechange = #{callback}`
		end

		self
	end

	def send (data = nil)
		raise 'the request has not been opened' unless opened?

		raise 'the request has already been sent' if sent?

		@headers.each {|name, value|
			`#@native.setRequestHeader(#{name.to_s}, #{value.to_s})`
		}

		if content_type
			header  = content_type
			header += "; charset=#{encoding}" if encoding

			`#@native.setRequestHeader('Content-Type', header)`
		end

		if binary?
			if required? 'typed-array'
				`#@native.responseType = 'arraybuffer'`
			else
				`#@native.overrideMimeType('text/plain; charset=x-user-defined')`
			end
		end

		if mime_type && !binary?
			`#@native.overrideMimeType(#@mime_type)`
		end

		`#@native.send(#{data || @parameters ? Parameters[data || @parameters].to_str : `null`})`

		sent!

		@response = Response.new(self)
	end

	def abort
		`#@native.abort()`
	end
end

end; end
