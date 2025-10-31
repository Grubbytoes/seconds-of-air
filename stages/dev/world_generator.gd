class_name WorldGenerator
extends Node

@export var target: TerrainTileMap

@onready var placement_noise := FastNoiseLite.new()
@onready var noise_seed = randi()


func _ready():
	placement_noise.seed = noise_seed
	placement_noise.noise_type = FastNoiseLite.TYPE_VALUE
	placement_noise.fractal_type = FastNoiseLite.FRACTAL_RIDGED
	placement_noise.fractal_octaves = 2
	placement_noise.fractal_gain = 0.3
	placement_noise.frequency = 0.18

	# * testing
	for i in range(10):
		var chunk = generate_chunk(i)
		build_chunk(chunk, i)


func generate_chunk(chunk_no := 0) -> IntArray2d:
	var new_chunk = IntArray2d.new(24, 24)
	var offset := Vector2i(0, chunk_no * 24)

	for c in new_chunk.coords():
		var n = placement_noise.get_noise_2dv(c + offset)
		if 0.3 > n:
			print("beep")
			new_chunk.setv(c, 1)
	
	return new_chunk


func build_chunk(chunk_data: IntArray2d, chunk_no := 0):
	var offset := Vector2i(0, chunk_no * 24)

	if chunk_data.width != 24 or chunk_data.height != 24:
		return
	
	for c in chunk_data.coords():
		var v = chunk_data.getv(c)
		if v == 1:
			print("boop")
			target.place_tile(c + offset)