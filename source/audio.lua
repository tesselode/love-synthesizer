local keymap = require 'keymap'
local Oscillator = require 'class.oscillator'
local parameters = require 'parameters'
local util = require 'util'
local Voice = require 'class.voice'

local source = love.audio.newQueueableSource(SAMPLE_RATE, BIT_DEPTH, CHANNELS)
local data = love.sound.newSoundData(BUFFER_SIZE, SAMPLE_RATE, BIT_DEPTH, CHANNELS)
local timer = 0
local sample = 0

local lfo = Oscillator()

local voices = {}

local function updateLfo()
	lfo.frequency = parameters.lfo.frequency:getValue()
	lfo.shape = parameters.lfo.shape:getValue()
	lfo.smooth = parameters.lfo.smooth:getValue()
	lfo:update()
end

local function clearFinishedVoices()
	for i = #voices, 1, -1 do
		if voices[i]:isFinished() then
			table.remove(voices, i)
		end
	end
end

local function getNextSample()
	updateLfo()
	local s = 0
	for _, voice in ipairs(voices) do
		voice:update()
		s = s + .1 * voice:getValue()
	end
	s = util.clamp(s, -1, 1)
	clearFinishedVoices()
	return s
end

local audio = {}

function audio.update(dt)
	timer = timer + dt
	while timer >= 1/SAMPLE_RATE do
		timer = timer - 1/SAMPLE_RATE
		data:setSample(sample, getNextSample())
		sample = sample + 1
		if sample == BUFFER_SIZE then
			sample = 0
			source:queue(data)
			source:play()
		end
	end
end

function audio.keypressed(key)
	if not keymap[key] then return false end
	table.insert(voices, Voice(keymap[key], lfo))
end

function audio.keyreleased(key)
	if not keymap[key] then return false end
	for i = #voices, 1, -1 do
		if voices[i].note == keymap[key] then
			voices[i]:release()
		end
	end
end

return audio