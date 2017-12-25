util = require 'util'

{
	Choice: class
		new: (@name, @choices, @default = 1) =>
			@value = @default

		getValue: => @choices[@value]

	Slider: class
		new: (@name, @min, @max, @default) =>
			@value = @default

		getValue: => util.lerp @min, @max, @value
}