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

class Navigator
	include Native

	def code
		`#@native.appCodeName`
	end

	def name
		`#@native.appName`
	end

	def version
		`#@native.appVersion`
	end

	def minor_version
		`#@native.appMinorVersion`
	end

	def build_id
		`#@native.buildID`
	end

	def cookies?
		`#@native.cookieEnabled`
	end

	def track?
		`!#@native.doNotTrack`
	end

	def language
		`#@native.language`
	end

	def mime_types
		`#@native.mimeTypes`
	end

	def offline?
		`!#@native.onLine`
	end

	def operating_system
		`#@native.oscpu`
	end; alias os operating_system

	def platform
		`#@native.platform`
	end

	def plugins
		`#@native.plugins`
	end

	def product
		`#@native.product`
	end

	def product_version
		`#@native.productSub`
	end

	def user_agent
		`#@native.userAgent`
	end

	def vendor
		`#@native.vendor`
	end

	def vendor_version
		`#@native.vendorSub`
	end

	def java?
		`#@native.javaEnabled()`
	rescue
		false
	end
end

end
