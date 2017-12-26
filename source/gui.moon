parameters = require 'parameters'
suit = require 'lib.suit'

{
	update: =>
		with suit.layout
			\reset 50, 50
			\padding 10, 10

			\push \col 400, 600
			suit.Label 'Oscillator 1', \row 200, 20
			parameters.oscillator[1].wave\updateGui!
			parameters.oscillator[1].pitch\updateGui!
			parameters.oscillator[1].pitchLfoMod\updateGui!
			parameters.oscillator[1].pitchEnvMod\updateGui!
			parameters.oscillator[1].shape\updateGui!
			parameters.oscillator[1].shapeLfoMod\updateGui!
			parameters.oscillator[1].shapeEnvMod\updateGui!
			parameters.oscillator[1].smooth\updateGui!
			parameters.oscillator[1].smoothLfoMod\updateGui!
			parameters.oscillator[1].smoothEnvMod\updateGui!
			\pop!

			\push \col 400, 600
			suit.Label 'Oscillator 2', \row 200, 20
			parameters.oscillator[2].wave\updateGui!
			parameters.oscillator[2].pitch\updateGui!
			parameters.oscillator[2].pitchLfoMod\updateGui!
			parameters.oscillator[2].pitchEnvMod\updateGui!
			parameters.oscillator[2].shape\updateGui!
			parameters.oscillator[2].shapeLfoMod\updateGui!
			parameters.oscillator[2].shapeEnvMod\updateGui!
			parameters.oscillator[2].smooth\updateGui!
			parameters.oscillator[2].smoothLfoMod\updateGui!
			parameters.oscillator[2].smoothEnvMod\updateGui!
			\pop!

			\push \col 400, 600
			suit.Label 'Filter', \row 200, 20
			parameters.filter.level\updateGui!
			parameters.filter.cutoff\updateGui!
			parameters.filter.cutoffLfoMod\updateGui!
			parameters.filter.cutoffEnvMod\updateGui!
			parameters.filter.resonance\updateGui!
			parameters.filter.resonanceLfoMod\updateGui!
			parameters.filter.resonanceEnvMod\updateGui!
			\pop!

			\reset 50, 450
			\padding 10, 10

			\push \col 400, 600
			suit.Label 'Volume envelope', \row 200, 20
			parameters.volumeEnvelope.a\updateGui!
			parameters.volumeEnvelope.d\updateGui!
			parameters.volumeEnvelope.s\updateGui!
			parameters.volumeEnvelope.r\updateGui!
			\pop!

			\push \col 400, 600
			suit.Label 'Mod envelope', \row 200, 20
			parameters.modEnvelope.a\updateGui!
			parameters.modEnvelope.d\updateGui!
			parameters.modEnvelope.s\updateGui!
			parameters.modEnvelope.r\updateGui!
			\pop!

			\push \col 400, 600
			suit.Label 'LFO', \row 200, 20
			parameters.lfo.frequency\updateGui!
			parameters.lfo.shape\updateGui!
			parameters.lfo.smooth\updateGui!
			\pop!

	draw: =>
		suit\draw!
}