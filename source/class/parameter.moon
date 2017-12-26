suit = require 'lib.suit'
util = require 'util'

Parameter = {}

class Parameter.Choice
	new: (@name, @choices, @default = 1) =>
		@value = @default

	getValue: => @choices[@value]

	updateGui: =>

class Parameter.Slider
	new: (@name, @min, @max, @default, @curve = 1) =>
		@value = ((@default - @min) / (@max - min)) ^ (1 / @curve)
		@slider = setmetatable {min: 0, max: 1, _value: @value}, {
			__index: (t, k) -> k == 'value' and t._value or rawget(t, k)
			__newindex: (t, k, v) ->
				if k == 'value'
					t._value = v
					@value = v
				else
					rawset t, k, v
		}

	getValue: => util.lerp @min, @max, @value ^ @curve

	updateGui: =>
		with suit
			.layout\push .layout\row 200, 20
			.Slider @slider, .layout\col 200, 20
			.Label @name..': '..@getValue!, {align: 'left'}, .layout\col 200, 20
			.layout\pop!

return Parameter