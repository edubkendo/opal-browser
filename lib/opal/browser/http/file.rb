#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class File
	def self.exists? (url)
		Browser::HTTP.head(url) { synchronous! }.success?
	end

	def self.read (url)
		response = Browser::HTTP.get(url) { synchronous! }

		if response.failure?
			raise ArgumentError, 'No such file or directory' unless File.exists?(url)
		else
			response.text
		end
	end

	def self.binread (url)
		response = Browser::HTTP.get(url) { synchronous! && binary! }

		if response.failure?
			raise ArgumentError, 'No such file or directory' unless File.exists?(url)
		else
			response.binary
		end
	end
end
