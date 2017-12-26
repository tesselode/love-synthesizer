Parameter = require 'class.parameter'

{
	oscillator:
		[1]:
			wave: Parameter.Choice 'Wave', {'sine', 'saw'}, 2
			pitch: Parameter.Slider 'Pitch', -24, 24, -12
			shape: Parameter.Slider 'Shape', .1, 100, 1
			smooth: Parameter.Slider 'Smooth', .1, 1, 1
		[2]:
			wave: Parameter.Choice 'Wave', {'sine', 'saw'}, 2
			pitch: Parameter.Slider 'Pitch', -24, 24, -12.1
			shape: Parameter.Slider 'Shape', .1, 100, 1
			smooth: Parameter.Slider 'Smooth', .1, 1, 1
	filter:
		cutoff: Parameter.Slider 'Cutoff', 0, .99, .99
		resonance: Parameter.Slider 'Resonance', 0, .9, 0
		level: Parameter.Slider 'Level', 1, 8, 4
	volumeEnvelope:
		a: Parameter.Slider 'Attack', .01, 10, .01
		d: Parameter.Slider 'Decay', .01, 10, 5
		s: Parameter.Slider 'Sustain', 0, 1, 1
		r: Parameter.Slider 'Release', .01, 10, .01
}