class_name ChunkBuilder
extends Node

## This class is responsible for physically placing game tiles and objects based on chunked data handed to it.
## It may also run 'garbage collection', clearing tiles and freeing objects that have been scrolled past

@export var ter: TerrainTileMap
@export var preload_chunks := 2
@export var clear_behind := 5
@export var initial_offset := 0

var chunk_sequencer := ChunkSequencer.new()

func _ready():
	for i in range(preload_chunks):
		build_next_chunk()


func build_next_chunk():
	var chunk := chunk_sequencer.next_chunk()
	var y_offset = initial_offset + (chunk_sequencer.chunk_count - 1) * Chunk.LENGTH

	build_chunk(chunk, y_offset)
	if chunk_sequencer.chunk_count >= clear_behind:
		erase_chunk(y_offset - Chunk.LENGTH * clear_behind)


func build_chunk(chunk: Chunk, y_offset = 0):
	var v := Vector2i.UP
	var v_offset = Vector2i(0, y_offset)
	var solid_tiles: Array[Vector2i] = []
	var solid_tiles_ptr = 0

	solid_tiles.resize(chunk.solid_terrain_count)
	
	for row in chunk.rows:
		v.y += 1
		v.x = 0
		if chunk.flipped_h:
			v.x = 23

		for o in row:
			var new_object_position = (v + v_offset) * 16

			# TODO this works but is spaghetti af sort it out m8
			if o == Chunk.ChunkObject.SOLID_TILE:
				solid_tiles[solid_tiles_ptr] = v + v_offset
				solid_tiles_ptr += 1
			elif o == Chunk.ChunkObject.DESTRUCTIBLE_TILE:
				ter.place_destructible_tile(v + v_offset)
			elif o == Chunk.ChunkObject.GEM:
				var g = Gem.create_random_gem()
				g.position = new_object_position 
				g.position += Vector2(8, 8)
				ter.add_child(g)
			elif o == Chunk.ChunkObject.SLUGBUG:
				var sb = preload("res://entities/characters/enemies/slugbug/slugbug.tscn").instantiate()
				sb.position = new_object_position 
				sb.position += Vector2(8, 8)
				ter.add_child(sb)
			elif o == Chunk.ChunkObject.ANGRY_SLUGBUG:
				var asb = preload("res://entities/characters/enemies/angry_slugbug/angry_slugbug.tscn").instantiate()
				asb.position = new_object_position 
				asb.position += Vector2(8, 8)
				ter.add_child(asb)
			elif o == Chunk.ChunkObject.CHEST:
				var ch := Chest.create_random_chest()
				ch.position = new_object_position
				ch.position += Vector2(16, 16)
				ter.add_child(ch)
			elif o == Chunk.ChunkObject.GEODE:
				var g := Geode.create_geode()
				g.position = new_object_position
				g.position += Vector2(16, 16)
				ter.add_child(g)
			
			# moving along the row (backwards if flipped)
			if chunk.flipped_h:
				v.x -= 1
			else:
				v.x += 1

	ter.place_solid_terrain(solid_tiles)
	ter.place_solid_terrain(chunk_walls(y_offset))


func erase_chunk(y_offset = 0):
	const CELLS_TO_ERASE = Chunk.AREA + Chunk.LENGTH * 2

	var v = Vector2i(-1, 0)
	var v_offset = Vector2i(0, y_offset)

	for i in range(CELLS_TO_ERASE):
		ter.erase_cell(v + v_offset)

		v.x += 1
		if v.x >= Chunk.LENGTH + 1:
			v.x = -1
			v.y += 1


func chunk_walls(y_offset: int) -> Array[Vector2i]:
	var walls: Array[Vector2i] = []
	walls.resize(48)

	for i in range(24):
		walls[i] = Vector2i(-1, i + y_offset)

	for i in range(24):
		walls[24+i] = Vector2i(24, i + y_offset)

	return walls
