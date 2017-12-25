Envelope = require 'class.envelope'
Oscillator = require 'class.oscillator'
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

	updateOscillators: =>
		for i, osc in ipairs @oscillators do with osc
			.wave = parameters.oscillator[i].wave\getValue!
			.frequency = util.noteToFrequency @note + parameters.oscillator[i].pitch\getValue!
			.shape = parameters.oscillator[i].shape\getValue!
			.smooth = parameters.oscillator[i].smooth\getValue!
			\update!

	updateEnvelopes: =>
		with @volumeEnvelope
			.a = parameters.volumeEnvelope.a\getValue!
			.d = parameters.volumeEnvelope.d\getValue!
			.s = parameters.volumeEnvelope.s\getValue!
			.r = parameters.volumeEnvelope.r\getValue!

	update: =>
		@updateOscillators!
		@updateEnvelopes!
		@v = 0
		for osc in *@oscillators do with osc
			@v += \getValue!
		with @volumeEnvelope
			\update!
			@v *= \getValue!

	release: =>
		@volumeEnvelope\release!

	isFinished: => @volumeEnvelope\isFinished!

	getValue: => @v