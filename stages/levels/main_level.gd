extends Node2D

@export var ter: TerrainTileMap


func _ready():
	var chunk := ChunkLoader.chunk_from_data(0, Chunk.Opening.CENTER)
	build_chunk(chunk)


func build_chunk(chunk: Chunk):
	var v := Vector2i.UP
	var solid_tiles: Array[Vector2i] = []
	var solid_tiles_ptr = 0

	solid_tiles.resize(chunk.solid_terrain_count)

	for row in chunk.rows:
		v.y += 1
		v.x = 0
		if chunk.flipped_h:
			v.x = 23

		for o in row:
			if o == Chunk.ChunkObject.SOLID_TILE:
				solid_tiles[solid_tiles_ptr] = v
				solid_tiles_ptr += 1
			elif 0 != Chunk.ChunkObject.EMPTY:
				ter.place_destructible_tile(v)
			
			# moving along the row (backwards if flipped)
			if chunk.flipped_h:
				v.x -= 1
			else:
				v.x += 1

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