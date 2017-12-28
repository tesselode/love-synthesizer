local Object = require 'lib.classic'
local util = require 'util'

local Oscillator = Object:extend()

function Oscillator:new()
	self.wave = 'sine'
	self.frequency = 440
	self.shape = 1
	self.smooth = 1
	self.phase = 0
	self.v = 0
end

function Oscillator:blep()
	local t = self.phase
	local dt = self.frequency / SAMPLE_RATE
	if t < dt then
		t = t / dt
		return t+t - t*t - 1
	elseif t > 1 - dt then
		t = (t - 1) / dt
		return t*t + t+t + 1
	else
		return 0
	end
end

function Oscillator:sine()
	return -math.sin(self.phase * 2 * math.pi)
end

function Oscillator:saw()
	return 2 * self.phase - 1 - self:blep()
end

function Oscillator:update()
	local shape = self.shape < .1 and .1 or self.shape
	local smooth = util.clamp(self.smooth, .1, 1)
	self.phase = self.phase + self.frequency / SAMPLE_RATE
	self.phase = self.phase % 1
	local v = self[self.wave](self)
	v = math.abs(v) ^ shape * util.sign(v)
	self.v = util.lerp(self.v, v, smooth)
end

function Oscillator:getValue()
	return self.v
end

return Oscillator