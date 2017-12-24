Oscillator = require 'oscillator'
util = require 'util'

class
	new: (@note) =>
		@oscillators = {}
		for i = 1, NUM_OSCILLATORS
			@oscillators[i] = Oscillator!
		@v = 0

	update: =>
		@v = 0
		for osc in *@oscillators do with osc
			.frequency = util.noteToFrequency @note
			\update!
			@v += \getValue!

	getValue: => @v