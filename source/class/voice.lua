local Envelope = require 'class.envelope'
local Filter = require 'class.filter'
local Object = require 'lib.classic'
local Oscillator = require 'class.oscillator'
local parameters = require 'parameters'
local util = require 'util'

local Voice = Object:extend()

function Voice:new(note, lfo)
	self.note = note
	self.lfo = lfo
	self.oscillators = {}
	for i = 1, NUM_OSCILLATORS do
		self.oscillators[i] = Oscillator()
	end
	self.volumeEnvelope = Envelope()
	self.modEnvelope = Envelope()
	self.filter = Filter()
	self.v = 0
end

function Voice:getOscillatorFrequency(i)
	local note = self.note
	note = note + parameters.oscillator[i].pitch:getValue()
	note = note + self.lfo:getValue() * parameters.oscillator[i].pitchLfoMod:getValue()
	note = note + self.modEnvelope:getValue() * parameters.oscillator[i].pitchEnvMod:getValue()
	return util.noteToFrequency(note)
end

function Voice:getOscillatorShape(i)
	local shape = parameters.oscillator[i].shape:getValue()
	shape = shape + self.lfo:getValue() * parameters.oscillator[i].shapeLfoMod:getValue()
	shape = shape + self.modEnvelope:getValue() * parameters.oscillator[i].shapeEnvMod:getValue()
	return shape
end

function Voice:getOscillatorSmooth(i)
	local smooth = parameters.oscillator[i].smooth:getValue()
	smooth = smooth + self.lfo:getValue() * parameters.oscillator[i].smoothLfoMod:getValue()
	smooth = smooth + self.modEnvelope:getValue() * parameters.oscillator[i].smoothEnvMod:getValue()
	return smooth
end

function Voice:updateOscillators()
	for i, oscillator in ipairs(self.oscillators) do
		oscillator.wave = parameters.oscillator[i].wave:getValue()
		oscillator.frequency = self:getOscillatorFrequency(i)
		oscillator.shape = self:getOscillatorShape(i)
		oscillator.smooth = self:getOscillatorSmooth(i)
		oscillator:update()
	end
end

function Voice:updateEnvelopes()
	self.volumeEnvelope.a = parameters.volumeEnvelope.a:getValue()
	self.volumeEnvelope.d = parameters.volumeEnvelope.d:getValue()
	self.volumeEnvelope.s = parameters.volumeEnvelope.s:getValue()
	self.volumeEnvelope.r = parameters.volumeEnvelope.r:getValue()
	self.volumeEnvelope:update()
	self.modEnvelope.a = parameters.modEnvelope.a:getValue()
	self.modEnvelope.d = parameters.modEnvelope.d:getValue()
	self.modEnvelope.s = parameters.modEnvelope.s:getValue()
	self.modEnvelope.r = parameters.modEnvelope.r:getValue()
	self.modEnvelope:update()
end

function Voice:getFilterCutoff()
	local cutoff = parameters.filter.cutoff:getValue()
	cutoff = cutoff + self.lfo:getValue() * parameters.filter.cutoffLfoMod:getValue()
	cutoff = cutoff + self.modEnvelope:getValue() * parameters.filter.cutoffEnvMod:getValue()
	return cutoff
end

function Voice:getFilterResonance()
	local resonance = parameters.filter.resonance:getValue()
	resonance = resonance + self.lfo:getValue() * parameters.filter.resonanceLfoMod:getValue()
	resonance = resonance + self.modEnvelope:getValue() * parameters.filter.resonanceEnvMod:getValue()
	return resonance
end

function Voice:updateFilter()
	self.filter.level = parameters.filter.level:getValue()
	self.filter.cutoff = self:getFilterCutoff()
	self.filter.resonance = self:getFilterResonance()
end

function Voice:update()
	self:updateOscillators()
	self:updateEnvelopes()
	self:updateFilter()
	self.v = 0
	for _, oscillator in ipairs(self.oscillators) do
		self.v = self.v + oscillator:getValue()
	end
	self.v = self.v * self.volumeEnvelope:getValue()
	self.v = self.filter:process(self.v)
end

function Voice:release()
	self.volumeEnvelope:release()
	self.modEnvelope:release()
end

function Voice:isFinished()
	return self.volumeEnvelope:isFinished()
end

function Voice:getValue()
	return self.v
end

return Voice