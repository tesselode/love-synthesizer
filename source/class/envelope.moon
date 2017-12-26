util = require 'util'

class Envelope
	new: (@a, @d, @s, @r) =>
		@a = .01
		@d = 5
		@s = 1
		@r = .01
		@t = 0
		@v = 0
		@released = false
		@releaseStart = 0

	update: =>
		@t += 1/SAMPLE_RATE
		if @released
			if @t < @r
				@v = util.lerp @releaseStart, 0, @t / @r
			else
				@v = 0
		else
			if @t < @a
				@v = util.lerp 0, 1, @t / @a
			elseif @t < @a + @d
				@v = util.lerp 1, @s, (@t - @a) / @d
			else
				@v = @s

	release: =>
		@released = true
		@releaseStart = @v
		@t = 0

	getValue: => @v

	isFinished: => @released and @v == 0