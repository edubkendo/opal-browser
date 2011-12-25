#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

module Browser; class Canvas

Context.define '2d' do
	class Style
		class Line
			attr_reader :context, :width, :cap, :join, :miter_limit

			def initialize (context)
				@context = context
			end

			def width= (value)
				`#{@context.to_native}.lineWidth = #{@width = value}`
			end

			def cap= (value)
				`#{@context.to_native}.lineCap = #{@cap = value}`
			end

			def join= (value)
				`#{@context.to_native}.lineJoin = #{@join = value}`
			end

			def miter_limit= (value)
				`#{@context.to_native}.miterLimit = #{@miter_limit = value}`
			end
		end

		class Text
			attr_reader :context, :font, :align, :baseline

			def initialize (context)
				@context = context
			end

			def font= (value)
				`#{@context.to_native}.font = #{@font = value}`
			end

			def align= (value)
				`#{@context.to_native}.textAlign = #{@align = value}`
			end

			def baseline= (value)
				`#{@context.to_native}.textBaseline = #{@baseline = value}`
			end
		end

		class Image
			attr_reader :context, :smooth

			alias smooth? smooth

			def initialize (context)
				@context = context
			end

			def smooth!
				`#{@context.to_native}.mozImageSmoothingEnabled = #{@smooth = true}`
			end

			def no_smooth!
				`#{@context.to_native}.mozImageSmoothingEnabled = #{@smooth = false}`
			end
		end

		attr_reader :context, :line, :text, :fill, :stroke, :alpha

		def initialize (context)
			@context = context
			@line    = Line.new(context)
			@text    = Text.new(context)
		end

		def fill= (value)
			`#{@context.to_native}.fillStyle = #{@fill = value}`
		end

		def stroke= (value)
			`#{@context.to_native}.strokeStyle = #{@stroke = value}`
		end

		def alpha= (value)
			`#{@context.to_native}.globalAlpha = #{@alpha = value}`
		end
	end

	class Text
		attr_reader :context

		def initialize (context)
			@context = context
		end

		def measure (text)
			`#{@context.to_native}.measureText(text)`
		end

		named :text, :x, :y, :max_width, :optional => 1 .. -1
		def fill (text, x = nil, y = nil, max_width = undefined)
			x ||= 0
			y ||= 0

			`#{@context.to_native}.fillText(text, x, y, max_width)`

			@context
		end

		named :text, :x, :y, :max_width, :optional => 1 .. -1
		def stroke (text, x = nil, y = nil, max_width = undefined)
			x ||= 0
			y ||= 0

			`#{@context.to_native}.strokeText(text, x, y, max_width)`

			@context
		end
	end

	attr_reader :style, :text

	def initialize (element)
		super(element)

		@native = `#@element.getContext('2d')`

		@style = Style.new(self)
		@text  = Text.new(self)
	end

	named :x, :y, :width, :height, :optional => 0 .. -1, :alias => { :w => :width, :h => :height }
	def clear (x = nil, y = nil, width = nil, height = nil)
		x      ||= 0
		y      ||= 0
		width  ||= self.width
		height ||= self.height

		`#@native.clearRect(x, y, width, height)`
	end

	def begin
		`#@native.beginPath()`

		self
	end

	def close
		`#@native.closePath()`

		self
	end

	def save
		`#@native.save()`

		self
	end

	def restore
		`#@native.restore()`

		self
	end

	named :x, :y
	def move_to (x, y)
		`#@native.moveTo(x, y)`

		self
	end

	alias move move_to

	named :x, :y
	def line_to (x, y)
		`#@native.lineTo(x, y)`

		self
	end

	def line (x1, y1, x2, y2)
		move_to x1, y1
		line_to x2, y2
	end

	named :x, :y, :width, :height, :alias => { :w => :width, :h => :height }
	def rect (x, y, width, height)
		`#@native.rect(x, y, width, height)`

		self
	end

	named :x, :y, :radius, :angle, :clockwise, :optional => { :clockwise => false }
	def arc (x, y, radius, angle, clockwise = false)
		`#@native.arc(x, y, radius, #{angle[:start]}, #{angle[:end]}, !clockwise)`

		self
	end

	def quadratic_curve_to (cp1x, cp1y, x, y)
		`#@native.quadraticCurveTo(cp1x, cp1y, x, y)`

		self
	end

	def bezier_curve_to (cp1x, cp1y, cp2x, cp2y, x, y)
		`#@native.bezierCurveTo(cp1x, cp1y, cp2x, cp2y, x, y)`

		self
	end

	def curve_to (*args)
		case args.length
		when 4 then quadratic_curve_to *args
		when 6 then bezier_curve_to *args
		else raise ArgumentError, "don't know where to dispatch"
		end

		self
	end

	def draw_image (*args)
		image = args.shift

		if args.first.is_a?(Hash)
			source, destination = args

			`#@native.drawImage(image, #{source[:x]}, #{source[:y]}, #{source[:width]}, #{source[:height]}, #{destination[:x]}, #{destination[:y]}, #{destination[:width]}, #{destination[:height]})`
		else
			x, y, width, height = args

			`#@native.drawImage(image, x, y, #{width || `undefined`}, #{height || `undefined`})`
		end

		self
	end

	def translate (x, y, &block)
		if block
			save

			`#@native.translate(x, y)`

			instance_eval &block

			restore
		else
			`#@native.translate(x, y)`
		end

		self
	end

	def rotate (angle, &block)
		if block
			save

			`#@native.rotate(angle)`

			instance_eval &block

			restore
		else
			`#@native.rotate(angle)`
		end

		self
	end

	def scale (x, y, &block)
		if block
			save

			`#@native.scale(x, y)`

			instance_eval &block

			restore
		else
			`#@native.scale(x, y)`
		end

		self
	end

	def transform (m11, m12, m21, m22, dx, dy, &block)
		if block
			save

			`#@native.transform(m11, m12, m21, m22, dx, dy)`

			instance_eval &block

			restore
		else
			`#@native.transform(m11, m12, m21, m22, dx, dy)`
		end

		self
	end

	def path (&block)
		`#@native.beginPath()`

		instance_eval &block

		`#@native.closePath()`

		self
	end

	def fill (&block)
		path &block if block

		`#@native.fill()`

		self
	end

	def stroke (&block)
		path &block if block

		`#@native.stroke()`

		self
	end
end

end; end
