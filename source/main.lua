SAMPLE_RATE = 44100
BIT_DEPTH = 16
CHANNELS = 1
BUFFER_SIZE = 512
NUM_OSCILLATORS = 2
FILTER_BUFFERS = 8

local audio = require 'audio'

function love.update(dt)
	audio.update(dt)
end

function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	end
	audio.keypressed(key)
end

function love.keyreleased(...)
	audio.keyreleased(...)
end