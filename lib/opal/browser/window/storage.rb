#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

module Browser; class Window

class Storage < Hash
	attr_reader :name

	def initialize (window, name)
		@window = window
		@name   = name

		autosave!

		init if respond_to? :init
	end

	def encoded_name
		"__opal.storage.#{@name}"
	end

	def autosave?;    @autosave;         end
	def autosave!;    @autosave = true;  end
	def no_autosave!; @autosave = false; end

	def replace (what)
		if what.is_a?(String)
			super JSON.parse(what)
		else
			super
		end
	end

	%w([] []= delete clear).each {|name|
		define_method name do |*args|
			super

			save if autosave?
		end
	}

	def save; end

	if !Opal.undefined?(`window.localStorage`)
		def init
			replace `#@window.localStorage[#{encoded_name}] || '{}'`
		end

		def save
			`#@window.localStorage[#{encoded_name}] = #{JSON.dump(self)}`
		end
	elsif !Opal.undefined?(`window.globalStorage`)
		def init
			replace `#@window.globalStorage[#@window.location.hostname][#{encoded_name}] || '{}'`
		end

		def save
			`#@window.globalStorage[#@window.location.hostname][#{encoded_name}] = #{JSON.dump(self)}`
		end
	elsif !Opal.undefined?(`document.body.addBehavior`)
		def init
			%x{
				self.element = #@window.document.createElement('link');
				self.element.addBehavior('#default#userData');

				#@window.document.getElementByTagName('head')[0].appendChild(self.element);

				self.element.load(#{encoded_name});
			}

			replace `self.element.getAttribute(#{encoded_name}) || '{}'`
		end

		def save
			%x{
				self.element.setAttribute(#{encoded_name}, #{JSON.dump(self)});
				self.element.save(#{encoded_name});
			}
		end
	else
		def init
			@document = Document.new(`#@window.document`)
			@document.cookies.options expires: 60 * 60 * 24 * 365

			replace @document.cookies[encoded_name]
		end

		def save
			@document.cookies[encoded_name] = self
		end
	end rescue nil
end

end; end
