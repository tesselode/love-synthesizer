class Filter
	new: =>
		@cutoff = .99
		@resonance = 0
		@level = 4
		@buffer = {}
		for i = 0, FILTER_BUFFERS
			@buffer[i] = 0

	process: (input) =>
		feedback = @resonance + @resonance / (1 - @cutoff)
		@buffer[0] += @cutoff * (input - @buffer[0] + feedback * (@buffer[0] - @buffer[1]))
		for i = 1, #@buffer
			@buffer[i] += @cutoff * (@buffer[i-1] - @buffer[i])
		return @buffer[@level]