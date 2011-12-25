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
	attr_accessor :style

	def initialize (element)
		super(element)

		@native = `#@element.getContext('2d')`
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
		if args.length == 4
			quadratic_curve_to *args
		elsif args.length == 6
			bezier_curve_to *args
		else
			raise ArgumentError, "don't know where to dispatch"
		end
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
