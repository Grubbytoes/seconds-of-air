class_name TerrainTileMap
extends TileMapLayer

const TILE_IDS = {
	"stone": [0, Vector2i(0, 0)]
}

func place_tile(coords: Vector2i, id := "stone") -> bool:
	var tile_id = TILE_IDS.get(id)

	if not tile_id:
		return false
	
	set_cell(coords, tile_id[0], tile_id[1])
	print("bop")
	return true