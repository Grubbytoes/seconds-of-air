extends Node2D

@export var ter: TerrainTileMap


func _ready():
	for i in range(24):
		var row: Array[Vector2i] = []
		row.resize(24)

		for j in range(2):
			row[j] = Vector2i(i, j)
		
		ter.place_solid_terrain(row)

	for i in range(24):
		for j in range(2, 4):
			ter.place_destructible_tile(Vector2i(i, j))
		
		
	
	
