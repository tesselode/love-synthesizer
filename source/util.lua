local util = {}

function util.lerp(a, b, f)
	return a + (b - a) * f
end

function util.sign(x)
	return x > 0 and 1 or x < 0 and -1 or 0
end

function util.clamp(x, a, b)
	return x < a and a or x > b and b or x
end

function util.noteToFrequency(n)
	return 440 * (2^(1/12)) ^ n
end

return util