Parameter = require 'class.parameter'

{
	oscillator:
		[1]:
			wave: Parameter.Choice 'Wave', {'sine', 'saw'}, 2
			pitch: Parameter.Slider 'Pitch', -24, 24, -12
			pitchLfoMod: Parameter.Slider 'Pitch LFO mod', -24, 24, 0
			shape: Parameter.Slider 'Shape', .1, 100, 1
			shapeLfoMod: Parameter.Slider 'Shape LFO mod', -100, 100, 0
			smooth: Parameter.Slider 'Smooth', .1, 1, 1
			smoothLfoMod: Parameter.Slider 'Smooth LFO mod', -1, 1, 0
		[2]:
			wave: Parameter.Choice 'Wave', {'sine', 'saw'}, 2
			pitch: Parameter.Slider 'Pitch', -24, 24, -12.1
			pitchLfoMod: Parameter.Slider 'Pitch LFO mod', -24, 24, 0
			shape: Parameter.Slider 'Shape', .1, 100, 1
			shapeLfoMod: Parameter.Slider 'Shape LFO mod', -100, 100, 0
			smooth: Parameter.Slider 'Smooth', .1, 1, 1
			smoothLfoMod: Parameter.Slider 'Smooth LFO mod', -1, 1, 0
	filter:
		cutoff: Parameter.Slider 'Cutoff', 0, .99, .5
		cutoffLfoMod: Parameter.Slider 'Cutoff LFO mod', -1, 1, 1
		resonance: Parameter.Slider 'Resonance', 0, .9, .5
		resonanceLfoMod: Parameter.Slider 'Resonance LFO mod', -1, 1, 1
		level: Parameter.Slider 'Level', 1, 8, 4
	volumeEnvelope:
		a: Parameter.Slider 'Attack', .01, 10, .01
		d: Parameter.Slider 'Decay', .01, 10, 5
		s: Parameter.Slider 'Sustain', 0, 1, 1
		r: Parameter.Slider 'Release', .01, 10, .01
	lfo:
		frequency: Parameter.Slider 'Frequency', .1, 100, 3
		shape: Parameter.Slider 'Shape', .1, 100, 1
		smooth: Parameter.Slider 'Smooth', .1, 1, 1
}