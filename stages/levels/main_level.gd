extends Node2D

@export var ter: TerrainTileMap


func _ready():
	build_chunk()


func build_chunk():
	var chunk := ChunkReader.read_chunk_file("test_chunk.json")
	var v := Vector2i.ZERO
	var solid_tiles: Array[Vector2i] = []
	var solid_tiles_ptr = 0

	solid_tiles.resize(chunk.solid_terrain_count)

	for o in chunk.chunk_objects:
		if o == Chunk.ChunkObject.SOLID_TILE:
			solid_tiles[solid_tiles_ptr] = v
			solid_tiles_ptr += 1
		elif o != Chunk.ChunkObject.EMPTY:
			ter.place_destructible_tile(v)

		print(v)
		v = increment_vector(v)
	
	print(solid_tiles)
	ter.place_solid_terrain(solid_tiles)
	ter.place_solid_terrain(chunk_walls(0))


func chunk_walls(_i: int) -> Array[Vector2i]:
	var walls: Array[Vector2i] = []
	walls.resize(48)

	for i in range(24):
		walls[i] = Vector2i(-1, i)

	for i in range(24):
		walls[24+i] = Vector2i(24, i)

	return walls


func increment_vector(v: Vector2i) -> Vector2i:
	v.x += 1
	if v.x >= 24:
		v.x = 0
		v.y += 1
	
	return v
