local Object = require 'lib.classic'
local util = require 'util'

local Envelope = Object:extend()

function Envelope:new(a, d, s, r)
	self.a, self.d, self.s, self.r = a, d, s, r
	self.t = 0
	self.v = 0
	self.released = false
	self.releaseStart = 0
end

function Envelope:update()
	self.t = self.t + 1/SAMPLE_RATE
	if self.released then
		if self.t < self.r then
			self.v = util.lerp(self.releaseStart, 0, self.t / self.r)
		else
			self.v = 0
		end
	else
		if self.t < self.a then
			self.v = util.lerp(0, 1, self.t / self.a)
		elseif self.t < self.a + self.d then
			self.v = util.lerp(1, self.s, (self.t - self.a) / self.d)
		else
			self.v = self.s
		end
	end
end

function Envelope:release()
	self.released = true
	self.releaseStart = self.v
	self.t = 0
end

function Envelope:getValue()
	return self.v
end

function Envelope:isFinished()
	return self.released and self.v == 0
end

return Envelope