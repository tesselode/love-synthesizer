keymap = require 'keymap'
Voice = require 'voice'

source = love.audio.newQueueableSource SAMPLE_RATE, BIT_DEPTH, CHANNELS
data = love.sound.newSoundData BUFFER_SIZE, SAMPLE_RATE, BIT_DEPTH, CHANNELS
timer = 0
sample = 0

voices = {}

clearFinishedVoices = ->
	for i = #voices, 1, -1 do with voices[i]
		table.remove voices, i if \isFinished!

getNextSample = ->
	s = 0
	for voice in *voices do with voice
		\update!
		s += .1 * \getValue!
	clearFinishedVoices!
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

	keypressed: (key) -> if keymap[key]
		table.insert voices, Voice keymap[key]

	keyreleased: (key) -> if keymap[key]
		for i = #voices, 1, -1 do with voices[i]
			\release! if .note == keymap[key]

	getActiveVoicesCount: => #voices
}