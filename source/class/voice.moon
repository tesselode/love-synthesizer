Envelope = require 'class.envelope'
Filter = require 'class.filter'
Oscillator = require 'class.oscillator'
parameters = require 'parameters'
util = require 'util'

class Voice
	new: (@note, @lfo) =>
		@oscillators = {}
		for i = 1, NUM_OSCILLATORS
			@oscillators[i] = Oscillator!
		@volumeEnvelope = Envelope!
		@modEnvelope = Envelope!
		@filter = Filter!
		@v = 0

	getOscillatorFrequency: (i) =>
		with parameters.oscillator[i]
			note = @note
			note += .pitch\getValue!
			note += @lfo\getValue! * .pitchLfoMod\getValue!
			note += @modEnvelope\getValue! * .pitchEnvMod\getValue!
			return util.noteToFrequency note

	getOscillatorShape: (i) =>
		with parameters.oscillator[i]
			shape = .shape\getValue!
			shape += @lfo\getValue! * .shapeLfoMod\getValue!
			shape += @modEnvelope\getValue! * .shapeEnvMod\getValue!
			return shape

	getOscillatorSmooth: (i) =>
		with parameters.oscillator[i]
			smooth = .smooth\getValue!
			smooth += @lfo\getValue! * .smoothLfoMod\getValue!
			smooth += @modEnvelope\getValue! * .smoothEnvMod\getValue!
			return smooth

	updateOscillators: =>
		for i, oscillator in ipairs @oscillators
			with oscillator
				.wave = parameters.oscillator[i].wave\getValue!
				.frequency = @getOscillatorFrequency i
				.shape = @getOscillatorShape i
				.smooth = @getOscillatorSmooth i
				\update!

	updateEnvelopes: =>
		with @volumeEnvelope
			.a = parameters.volumeEnvelope.a\getValue!
			.d = parameters.volumeEnvelope.d\getValue!
			.s = parameters.volumeEnvelope.s\getValue!
			.r = parameters.volumeEnvelope.r\getValue!
			\update!
		with @modEnvelope
			.a = parameters.modEnvelope.a\getValue!
			.d = parameters.modEnvelope.d\getValue!
			.s = parameters.modEnvelope.s\getValue!
			.r = parameters.modEnvelope.r\getValue!
			\update!

	getFilterCutoff: =>
		with parameters.filter
			cutoff = .cutoff\getValue!
			cutoff += @lfo\getValue! * .cutoffLfoMod\getValue!
			cutoff += @modEnvelope\getValue! * .cutoffEnvMod\getValue!
			return cutoff

	getFilterResonance: =>
		with parameters.filter
			resonance = .resonance\getValue!
			resonance += @lfo\getValue! * .resonanceLfoMod\getValue!
			resonance += @modEnvelope\getValue! * .resonanceEnvMod\getValue!
			return resonance

	updateFilter: =>
		with @filter
			.level = parameters.filter.level\getValue!
			.cutoff = @getFilterCutoff!
			.resonance = @getFilterResonance!

	update: =>
		@updateOscillators!
		@updateEnvelopes!
		@updateFilter!
		@v = 0
		for oscillator in *@oscillators
			@v += oscillator\getValue!
		@v *= @volumeEnvelope\getValue!
		@v = @filter\process @v

	release: =>
		@volumeEnvelope\release!
		@modEnvelope\release!

	isFinished: => @volumeEnvelope\isFinished!

	getValue: => @v