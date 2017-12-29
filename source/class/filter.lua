local Object = require 'lib.classic'
local util = require 'util'

local Filter = Object:extend()

function Filter:new()
	self.cutoff = .99
	self.resonance = 0
	self.level = 4
	self.buffer = {}
	for i = 1, FILTER_BUFFERS do
		self.buffer[i] = 0
	end
end

-- Karlsen fast ladder
function Filter:process(input)
	local cutoff = util.clamp(self.cutoff, 0, .99)
	local resonance = util.clamp(self.resonance, 0, .9)
	local level = math.floor(self.level)

	local rscl = self.buffer[level]
	if rscl > 1 then rscl = 1 end
	self.buffer[1] = (-rscl * resonance) + input
	for i = 2, #self.buffer do
		self.buffer[i] = self.buffer[i] + cutoff * (self.buffer[i-1] - self.buffer[i])
	end
	return self.buffer[level]
end

return Filter