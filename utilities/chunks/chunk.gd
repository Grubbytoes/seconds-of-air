class_name Chunk
extends Resource

enum ChunkObject {
	EMPTY,
	SOLID_TILE,
	DESTRUCTIBLE_TILE,
	COIN,
	AIR_BUBBLE,
	ENEMY
}

const CHUNK_OBJECT_IDS = {
	's': ChunkObject.SOLID_TILE,
	'x': ChunkObject.DESTRUCTIBLE_TILE
}

var solid_terrain_count := 0
var chunk_objects: PackedInt32Array = []

func load(d: Dictionary) -> bool:
	if !d.has_all(["map", "terrain_count"]):
		return false

	chunk_objects.resize(576)
	chunk_objects.fill(ChunkObject.EMPTY)
	solid_terrain_count = 0
	var objects_counter = 0

	for row in d["map"]:
		for c in row:
			var obj = CHUNK_OBJECT_IDS.get(c, ChunkObject.EMPTY)
			chunk_objects[objects_counter] = obj
			objects_counter += 1

			# increment solid terrain count, if necessary
			if obj == ChunkObject.SOLID_TILE:
				solid_terrain_count += 1			
	
	return true
