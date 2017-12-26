util = require 'util'

class Oscillator
	new: =>
		@wave = 'sine'
		@frequency = 440
		@shape = 1
		@smooth = 1
		@phase = 0
		@v = 0

	blep: =>
		t = @phase
		dt = @frequency / SAMPLE_RATE
		if t < dt
			t /= dt
			return t+t - t*t - 1
		elseif t > 1 - dt
			t = (t - 1) / dt
			return t*t + t+t + 1
		else
			return 0

	sine: => -math.sin @phase * 2 * math.pi

	saw: => 2 * @phase - 1 - @blep!

	update: =>
		shape = @shape < .1 and .1 or @shape
		smooth = util.clamp @smooth, .1, 1
		@phase += @frequency / SAMPLE_RATE
		@phase %= 1
		v = @[@wave] @
		v = math.abs(v) ^ shape * util.sign(v)
		@v = util.lerp @v, v, smooth

	getValue: => @v