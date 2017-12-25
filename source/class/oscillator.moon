class
	new: =>
		@phase = 0
		@frequency = 440
		@v = 0

	update: =>
		@phase += @frequency / SAMPLE_RATE
		while @phase >= 1
			@phase -= 1
		@v = math.sin @phase * 2 * math.pi

	getValue: => @v