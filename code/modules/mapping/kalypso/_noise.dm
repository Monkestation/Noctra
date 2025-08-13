GLOBAL_VAR_INIT(noise_seed, 0)

/proc/init_world_seed(seed = 0)
	if(!seed)
		seed = rand(1, 999999)
	GLOB.noise_seed = seed
	world.log << "World seed: [seed]"

/proc/hash_int(value, seed)
	var/hash = value + seed
	hash = (hash * 73) % 65536
	hash = (hash + (hash >> 8)) % 65536
	hash = (hash * 37) % 65536
	return hash

/proc/hash_coords(x, y, seed)
	var/ix = round(x) % 1000
	var/iy = round(y) % 1000

	var/hash = hash_int(ix, seed)
	hash = hash_int(hash + iy, seed + 1)
	hash = hash_int(hash, seed + 2)

	return hash % 32768

//this is like cavemen level noise, used in a few places
/proc/simple_noise(x, y, seed = 0)
	var/combined_seed = (GLOB.noise_seed + seed)
	var/hash = hash_coords(x * 100, y * 100, combined_seed)
	return (hash / 16384.0) - 1.0

/proc/dot_point_noise(x, y, seed = 0)
	var/combined_seed = (GLOB.noise_seed + seed)

	// Get integer and fractional parts
	var/xi = floor(x)
	var/yi = floor(y)
	var/xf = x - xi
	var/yf = y - yi

	// Generate gradients at corners
	var/g00 = hash_gradient(xi, yi, combined_seed)
	var/g10 = hash_gradient(xi + 1, yi, combined_seed)
	var/g01 = hash_gradient(xi, yi + 1, combined_seed)
	var/g11 = hash_gradient(xi + 1, yi + 1, combined_seed)

	// Calculate dot products
	var/d00 = dot_product(g00, xf, yf)
	var/d10 = dot_product(g10, xf - 1, yf)
	var/d01 = dot_product(g01, xf, yf - 1)
	var/d11 = dot_product(g11, xf - 1, yf - 1)

	// Smooth interpolation
	var/sx = smooth_step(xf)
	var/sy = smooth_step(yf)

	// Interpolate
	var/i1 = lerp(d00, d10, sx)
	var/i2 = lerp(d01, d11, sx)
	return lerp(i1, i2, sy)

/proc/dot_point_noise_octaves(x, y, seed = 0, octaves = 3, persistence = 0.5)
	var/value = 0
	var/amplitude = 1
	var/frequency = 1
	var/max_value = 0

	for(var/i = 0; i < octaves; i++)
		value += dot_point_noise(x * frequency, y * frequency, seed + i * 10000) * amplitude
		max_value += amplitude
		amplitude *= persistence
		frequency *= 2

	return value / max_value


/proc/hash_gradient(x, y, seed)
	var/hash = hash_coords(x, y, seed) % 8
	switch(hash)
		if(0) return list(1, 1)
		if(1) return list(-1, 1)
		if(2) return list(1, -1)
		if(3) return list(-1, -1)
		if(4) return list(1, 0)
		if(5) return list(-1, 0)
		if(6) return list(0, 1)
		if(7) return list(0, -1)

/proc/dot_product(list/gradient, x, y)
	return gradient[1] * x + gradient[2] * y

/proc/smooth_step(t)
	return t * t * (3 - 2 * t)

/proc/get_terrain_noise(x, y, biome_id, layer = "base")
	var/base_seed = 0
	switch(biome_id)
		if(BIOME_FOREST)
			base_seed = 1000
		if(BIOME_MOUNTAIN)
			base_seed = 2000
		if(BIOME_SWAMP)
			base_seed = 3000

	switch(layer)
		if("base")
			return dot_point_noise_octaves(x * 0.003, y * 0.003, base_seed + 1, 3, 0.5)
		if("detail")
			return dot_point_noise_octaves(x * 0.008, y * 0.008, base_seed + 2, 2, 0.4)
		if("moisture")
			return dot_point_noise_octaves(x * 0.005, y * 0.005, base_seed + 3, 2, 0.3)
		if("rock")
			return dot_point_noise_octaves(x * 0.0025, y * 0.0025, base_seed + 4, 3, 0.6)
