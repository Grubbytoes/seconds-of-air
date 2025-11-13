extends Node2D

@export var ter: TerrainTileMap


func _ready():
	build_chunk()


func build_chunk():
	var json_chunk := ChunkReader.read_chunk_file("test_chunk.json")
	var map = json_chunk.data["map"]
	var terrain_count = json_chunk.data["terrain_count"]
	var terrain_array: Array[Vector2i] = []
	var y = 0
	var x = 0
	terrain_array.resize(terrain_count)

	for row in map:
		for c in row:
			if c == 'x':
				ter.place_destructible_tile(Vector2i(x, y))
			elif c == 's':
				terrain_count -= 1
				terrain_array[terrain_count] = Vector2i(x, y)
			x += 1

		y += 1
		x = 0
		print(row)
	
	ter.place_solid_terrain(terrain_array)

	

		
		
	
	
