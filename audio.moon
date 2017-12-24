Oscillator = require 'oscillator'

source = love.audio.newQueueableSource SAMPLE_RATE, BIT_DEPTH, CHANNELS
data = love.sound.newSoundData BUFFER_SIZE, SAMPLE_RATE, BIT_DEPTH, CHANNELS
timer = 0
sample = 0

osc = Oscillator!

getNextSample = ->
	s = 0
	osc\update!
	s += .1 * osc\getValue!
	s

return {
	update: (dt) ->
		timer += dt
		while timer >= 1/SAMPLE_RATE
			timer -= 1/SAMPLE_RATE
			data\setSample sample, getNextSample!
			sample += 1
			if sample == BUFFER_SIZE
				sample = 0
				with source
					\queue data
					\play!
}