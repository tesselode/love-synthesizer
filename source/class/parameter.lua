local Object = require 'lib.classic'
local suit = require 'lib.suit'
local util = require 'util'

local Parameter = {}

Parameter.Choice = Object:extend()

function Parameter.Choice:new(name, choices, default)
	self.name = name
	self.choices = choices
	self.default = default or 1
	self.value = self.default
	self.slider = setmetatable({
		min = 1,
		max = #self.choices,
		_value = self.value,
	}, {
		__index = function(t, k)
			return k == 'value' and t._value or rawget(t, k)
		end,
		__newindex = function(t, k, v)
			if k == 'value' then
				t._value = v
				self.value = math.floor(v)
			else
				rawset(t, k, v)
			end
		end,
	})
end

function Parameter.Choice:getValue()
	return self.choices[self.value]
end

function Parameter.Choice:updateGui()
	suit.layout:push(suit.layout:row(200, 20))
	suit.Slider(self.slider, suit.layout:col(200, 20))
	suit.Label(self.name .. ': ' .. self:getValue(), {align = 'left'},
		suit.layout:col(200, 20))
	suit.layout:pop()
end

Parameter.Slider = Object:extend()

function Parameter.Slider:new(name, min, max, default, curve)
	self.name = name
	self.min = min
	self.max = max
	self.default = default
	self.curve = curve or 1
	self.value = ((self.default - self.min) / (self.max - self.min)) ^ (1 / self.curve)
	self.slider = setmetatable({
		min = 0,
		max = 1,
		_value = self.value,
	}, {
		__index = function(t, k)
			return k == 'value' and t._value or rawget(t, k)
		end,
		__newindex = function(t, k, v)
			if k == 'value' then
				t._value = v
				self.value = v
			else
				rawset(t, k, v)
			end
		end,
	})
end

function Parameter.Slider:getValue()
	return util.lerp(self.min, self.max, self.value ^ self.curve)
end

function Parameter.Slider:updateGui()
	suit.layout:push(suit.layout:row(200, 20))
	suit.Slider(self.slider, suit.layout:col(200, 20))
	suit.Label(self.name .. ': ' .. self:getValue(), {align = 'left'},
		suit.layout:col(200, 20))
	suit.layout:pop()
end

return Parameter