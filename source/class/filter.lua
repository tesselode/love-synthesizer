local Object = require 'lib.classic'
local util = require 'util'

local Filter = Object:extend()

function Filter:new()
	self.cutoff = .99
	self.resonance = 0
	self.level = 4
	self.buffer = {}
	for i = 0, FILTER_BUFFERS do
		self.buffer[i] = 0
	end
end

function Filter:process(input)
	local cutoff = util.clamp(self.cutoff, 0, .99)
	local resonance = util.clamp(self.resonance, 0, .9)
	local feedback = resonance + resonance / (1 - cutoff)
	self.buffer[0] = self.buffer[0] + cutoff * (input - self.buffer[0] + feedback * (self.buffer[0] - self.buffer[1]))
	for i = 1, #self.buffer do
		self.buffer[i] = self.buffer[i] + cutoff * (self.buffer[i-1] - self.buffer[i])
	end
	return self.buffer[math.floor(self.level)]
end

return Filter