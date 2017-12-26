keymap = require 'keymap'
Oscillator = require 'class.oscillator'
parameters = require 'parameters'
util = require 'util'
Voice = require 'class.voice'

source = love.audio.newQueueableSource SAMPLE_RATE, BIT_DEPTH, CHANNELS
data = love.sound.newSoundData BUFFER_SIZE, SAMPLE_RATE, BIT_DEPTH, CHANNELS
timer = 0
sample = 0

lfo = Oscillator!

voices = {}

updateLfo = ->
	with lfo
		.frequency = parameters.lfo.frequency\getValue!
		.shape = parameters.lfo.shape\getValue!
		.smooth = parameters.lfo.smooth\getValue!
		\update!

clearFinishedVoices = ->
	for i = #voices, 1, -1
		table.remove voices, i if voices[i]\isFinished!

getNextSample = ->
	updateLfo!
	s = 0
	for voice in *voices
		voice\update!
		s += .1 * voice\getValue!
	s = util.clamp s, -1, 1
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
			table.insert voices, Voice keymap[key], lfo

	keyreleased: (key) ->
		if keymap[key]
			for i = #voices, 1, -1
				if voices[i].note == keymap[key]
					voices[i]\release!

	getActiveVoicesCount: => #voices
}