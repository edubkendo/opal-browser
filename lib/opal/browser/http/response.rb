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

class Response
	include Native

	attr_reader :request

	def initialize (request)
		super(request.to_native)

		@request = request
	end

	def headers
		@headers ||= Headers.parse(`#@native.getAllResponseHeaders()`)
	end

	def text
		%x{
			var result = #@native.responseText;

			if (!result) {
				return nil;
			}

			return result;
		}
	end

	def xml
		%x{
			var result = #@native.responseXML;

			if (!result) {
				return nil;
			}

			return #{Document(`result`)};
		}
	end

	def binary
		%x{
			var result = #@native.response;

			if (!result) {
				return nil;
			}

			return #{Buffer.from_native(`result`)};
		}
	end
end

end; end
