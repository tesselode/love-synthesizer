keymap = require 'keymap'
Voice = require 'class.voice'

source = love.audio.newQueueableSource SAMPLE_RATE, BIT_DEPTH, CHANNELS
data = love.sound.newSoundData BUFFER_SIZE, SAMPLE_RATE, BIT_DEPTH, CHANNELS
timer = 0
sample = 0

voices = {}

clearFinishedVoices = ->
	for i = #voices, 1, -1
		if voices[i]\isFinished!
			table.remove voices, i

getNextSample = ->
	s = 0
	for voice in *voices
		voice\update!
		s += .1 * voice\getValue!
	clearFinishedVoices!
	return s

return {
	update: (dt) ->
		timer += dt
		while timer >= 1/SAMPLE_RATE
			timer -= 1/SAMPLE_RATE
			data\setSample sample, getNextSample!
			sample += 1
			if sample == BUFFER_SIZE
				sample = 0
				source\queue data
				source\play!

	keypressed: (key) ->
		if keymap[key]
			table.insert voices, Voice keymap[key]

	keyreleased: (key) ->
		if keymap[key]
			for i = #voices, 1, -1
				if voices[i].note == keymap[key]
					voices[i]\release!

	getActiveVoicesCount: => #voices
}