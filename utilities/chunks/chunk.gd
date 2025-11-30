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

enum Opening {
	LEFT, CENTER, RIGHT
}

static var chunk_object_ids = {
	's': ChunkObject.SOLID_TILE,
	'x': ChunkObject.DESTRUCTIBLE_TILE
}

var top_opening := Opening.CENTER
var bottom_opening := Opening.CENTER
var flipped_h := false
var solid_terrain_count := 0
var rows: Array[PackedInt32Array] = []


func load(d: Dictionary) -> bool:
	if !d.has_all(["map", "terrain_count"]):
		return false

	rows.clear()
	solid_terrain_count = 0

	for map_row: String in d["map"]:
		var new_row = PackedInt32Array() 
		var i = 0

		new_row.resize(24)

		for c in map_row:
			var obj = chunk_object_ids.get(c, ChunkObject.EMPTY)
			new_row[i] = obj
			i += 1

			# increment solid terrain count, if necessary
			if obj == ChunkObject.SOLID_TILE:
				solid_terrain_count += 1	

		rows.append(new_row)		
	
	return true


func flip_h():
	flipped_h = !flipped_h