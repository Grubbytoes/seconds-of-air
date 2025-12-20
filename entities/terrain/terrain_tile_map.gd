class_name TerrainTileMap
extends TileMapLayer

const TILE_IDS = {
	"grey": [0, Vector2i(0, 0)]
}

var packed_destroy_effect := preload("res://entities/vfx/tile_destroy_effect.tscn")	


func place_destructible_tile(coords: Vector2i, id := "grey") -> bool:

	var tile_id = TILE_IDS.get(id) as Array

	if not tile_id:
		return false

	var atlas_id = tile_id[0]
	var atlas_coords = Vector2(tile_id[1] as Vector2)
	
	# adding variation
	atlas_coords.x = randi() % 4

	set_cell(coords, atlas_id, atlas_coords, random_transpose())

	return true


func place_solid_terrain(coords: Array[Vector2i]):
	set_cells_terrain_connect(coords, 0, 0)


func destroy_tile(coords: Vector2) -> bool:
	var tile_data = get_cell_tile_data(coords)
	if tile_data == null:
		return false
	elif not tile_data.get_custom_data("destructible"):
		return false
	
	# clear cell
	erase_cell(coords)

	# play sound
	SoundManager.play_sound("tile_break")

	# TODO make better lol
	# random drop
	if randi() % 8 == 0:
		var drop_position = coords * 16 + Vector2(8, 8)
		Gem.drop_random(self, drop_position, Vector2(50, 0), 2 * PI)
	# play effects
	var vfx := packed_destroy_effect.instantiate()
	vfx.position = coords * 16
	add_child(vfx)

	return true


func random_transpose():
	var r = randi() % 4

	match r:
		1:
			return TileSetAtlasSource.TRANSFORM_FLIP_H
		2:
			return TileSetAtlasSource.TRANSFORM_FLIP_V
		3:
			return (
				TileSetAtlasSource.TRANSFORM_FLIP_V |
				TileSetAtlasSource.TRANSFORM_FLIP_H
			)
	
	return 0

		