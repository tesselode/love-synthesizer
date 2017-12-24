return {
	lerp: (a, b, f) -> a + (b - a) * f

	noteToFrequency: (n) -> 440 * (2^(1/12)) ^ n
}