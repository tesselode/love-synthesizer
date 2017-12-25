class
	new: =>
		@wave = 'sine'
		@frequency = 440
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
		0

	sine: => math.sin @phase * 2 * math.pi

	saw: => 2 * @phase - 1 - @blep!

	update: =>
		@phase += @frequency / SAMPLE_RATE
		@phase %= 1
		@v = @[@wave] @

	getValue: => @v