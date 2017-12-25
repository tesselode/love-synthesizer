Parameter = require 'class.parameter'

{
	oscillator:
		[1]:
			wave: Parameter.Choice 'wave', {'sine', 'saw'}, 2
		[2]:
			wave: Parameter.Choice 'wave', {'sine', 'saw'}, 2
	volumeEnvelope:
		a: Parameter.Slider 'Attack', 0.01, 10, 0
		d: Parameter.Slider 'Decay', 0.01, 10, 0
		s: Parameter.Slider 'Sustain', 0, 1, 1
		r: Parameter.Slider 'Release', 0.01, 10, 0
}