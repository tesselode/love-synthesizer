util = require 'util'

{
	Slider: class
		new: (@name, @min, @max, @default) =>
			@value = @default

		getValue: => util.lerp @min, @max, @value
}