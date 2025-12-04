class_name ChunkBuilder
extends Node

## This class is responsible for physically placing game tiles and objects based on chunked data handed to it.
## It may also run 'garbage collection', clearing tiles and freeing objects that have been scrolled past

@export var ter: TerrainTileMap
@export var preload_chunks := 2
@export var initial_offset := 0

var chunk_sequencer := ChunkSequencer.new()

func _ready():
	for i in range(preload_chunks):
		build_next_chunk()


func build_next_chunk():
	var chunk := chunk_sequencer.next_chunk()
	var y_offset = initial_offset + (chunk_sequencer.chunk_count - 1) * 24

	build_chunk(chunk, y_offset)


func build_chunk(chunk: Chunk, y_offset = 0):
	var v := Vector2i.UP
	var v_offset = Vector2i(0, y_offset)
	var solid_tiles: Array[Vector2i] = []
	var solid_tiles_ptr = 0

	solid_tiles.resize(chunk.solid_terrain_count)
	print("building chunk")

	for row in chunk.rows:
		v.y += 1
		v.x = 0
		if chunk.flipped_h:
			v.x = 23

		for o in row:
			if o == Chunk.ChunkObject.SOLID_TILE:
				solid_tiles[solid_tiles_ptr] = v + v_offset
				solid_tiles_ptr += 1
			elif o != Chunk.ChunkObject.EMPTY:
				ter.place_destructible_tile(v + v_offset)
			
			# moving along the row (backwards if flipped)
			if chunk.flipped_h:
				v.x -= 1
			else:
				v.x += 1

	ter.place_solid_terrain(solid_tiles)
	ter.place_solid_terrain(chunk_walls(y_offset))


func chunk_walls(y_offset: int) -> Array[Vector2i]:
	var walls: Array[Vector2i] = []
	walls.resize(48)

	for i in range(24):
		walls[i] = Vector2i(-1, i + y_offset)

	for i in range(24):
		walls[24+i] = Vector2i(24, i + y_offset)

	return walls
