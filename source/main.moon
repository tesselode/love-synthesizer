export SAMPLE_RATE = 44100
export BIT_DEPTH = 16
export CHANNELS = 1
export BUFFER_SIZE = 512
export NUM_OSCILLATORS = 2
export FILTER_BUFFERS = 8

audio = require 'audio'
gui = require 'gui'

love.update = (dt) ->
	gui.update!
	audio.update dt

love.keypressed = (key) ->
	love.event.quit! if key == 'escape'
	audio.keypressed key

love.keyreleased = (...) -> audio.keyreleased ...

love.draw = ->
	gui.draw!