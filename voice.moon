Envelope = require 'envelope'
Oscillator = require 'oscillator'
util = require 'util'

class
	new: (@note) =>
		@oscillators = {}
		for i = 1, NUM_OSCILLATORS
			@oscillators[i] = Oscillator!
		@volumeEnvelope = Envelope 1, 2, .5, 3
		@v = 0

	update: =>
		@v = 0
		for osc in *@oscillators do with osc
			.frequency = util.noteToFrequency @note
			\update!
			@v += \getValue!
		with @volumeEnvelope
			\update!
			@v *= \getValue!

	release: =>
		@volumeEnvelope\release!

	isFinished: => @volumeEnvelope\isFinished!

	getValue: => @v