extends Node2D

@export var ter: TerrainTileMap


func _ready():
	build_chunk()


func build_chunk():
	var json_chunk := ChunkReader.read_chunk_file("test_chunk.json")
	var v2i_ptr := Vector2i.ZERO

	print(len(json_chunk.chunk_objects))

	for o in json_chunk.chunk_objects:
		if 0 == Chunk.ChunkObject.SOLID_TILE:
			pass
		elif o != Chunk.ChunkObject.EMPTY:
			pass

		# print("%s, %s" % [v2i_ptr, o])
		v2i_ptr.x += 1
		if v2i_ptr.x >= 24:
			v2i_ptr.x = 0
			v2i_ptr.y += 1
	
	# ter.place_solid_terrain(terrain_array)