Envelope = require 'envelope'
Oscillator = require 'oscillator'
parameters = require 'parameters'
util = require 'util'

class
	new: (@note) =>
		@oscillators = {}
		for i = 1, NUM_OSCILLATORS
			@oscillators[i] = Oscillator!
		with parameters.volumeEnvelope
			@volumeEnvelope = Envelope .a\getValue!, .d\getValue!,
				.s\getValue!, .r\getValue!
		@v = 0

	updateEnvelopes: =>
		with @volumeEnvelope
			.a = parameters.volumeEnvelope.a\getValue!
			.d = parameters.volumeEnvelope.d\getValue!
			.s = parameters.volumeEnvelope.s\getValue!
			.r = parameters.volumeEnvelope.r\getValue!

	update: =>
		@updateEnvelopes!
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