Envelope = require 'class.envelope'
Oscillator = require 'class.oscillator'
parameters = require 'parameters'
util = require 'util'

class Voice
	new: (@note) =>
		@oscillators = {}
		for i = 1, NUM_OSCILLATORS
			@oscillators[i] = Oscillator!
		@volumeEnvelope = Envelope(
			parameters.volumeEnvelope.a\getValue!,
			parameters.volumeEnvelope.d\getValue!,
			parameters.volumeEnvelope.s\getValue!,
			parameters.volumeEnvelope.r\getValue!
		)
		@v = 0

	updateOscillators: =>
		for i, oscillator in ipairs @oscillators
			with oscillator
				.wave = parameters.oscillator[i].wave\getValue!
				.frequency = util.noteToFrequency(@note + parameters.oscillator[i].pitch\getValue!)
				.shape = parameters.oscillator[i].shape\getValue!
				.smooth = parameters.oscillator[i].smooth\getValue!
				\update!

	updateEnvelopes: =>
		with @volumeEnvelope
			.a = parameters.volumeEnvelope.a\getValue!
			.d = parameters.volumeEnvelope.d\getValue!
			.s = parameters.volumeEnvelope.s\getValue!
			.r = parameters.volumeEnvelope.r\getValue!
			\update!

	update: =>
		@updateOscillators!
		@updateEnvelopes!
		@v = 0
		for oscillator in *@oscillators
			@v += oscillator\getValue!
		@v *= @volumeEnvelope\getValue!

	release: =>
		@volumeEnvelope\release!

	isFinished: => @volumeEnvelope\isFinished!

	getValue: => @v