Parameter = require 'class.parameter'

{
	oscillator:
		[1]:
			wave: Parameter.Choice 'Wave', {'sine', 'saw'}, 2
			pitch: Parameter.Slider 'Pitch', -24, 24, .25
			shape: Parameter.Slider 'Shape', .1, 100, .9/(100-.1)
			smooth: Parameter.Slider 'Smooth', .1, 1, 1
		[2]:
			wave: Parameter.Choice 'Wave', {'sine', 'saw'}, 2
			pitch: Parameter.Slider 'Pitch', -24, 24, .252
			shape: Parameter.Slider 'Shape', .1, 100, .9/(100-.1)
			smooth: Parameter.Slider 'Smooth', .1, 1, 1
	volumeEnvelope:
		a: Parameter.Slider 'Attack', 0.01, 10, 0
		d: Parameter.Slider 'Decay', 0.01, 10, 0
		s: Parameter.Slider 'Sustain', 0, 1, 1
		r: Parameter.Slider 'Release', 0.01, 10, 0
}