util = require 'util'

Parameter = {}

class Parameter.Choice
	new: (@name, @choices, @default = 1) =>
		@value = @default

	getValue: => @choices[@value]

class Parameter.Slider
	new: (@name, @min, @max, @default) =>
		@value = @default

	getValue: => util.lerp @min, @max, @value

return Parameter