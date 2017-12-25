return {
	lerp: (a, b, f) -> a + (b - a) * f

	sign: (x) -> x > 0 and 1 or x < 0 and -1 or 0

	noteToFrequency: (n) -> 440 * (2^(1/12)) ^ n
}