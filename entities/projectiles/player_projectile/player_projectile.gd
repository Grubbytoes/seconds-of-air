extends Projectile

# * OVERRIDE
func contact(c: KinematicCollision2D):
	var collider = c.get_collider()

	if collider is TerrainTileMap:
		var tile_position = collider.local_to_map(c.get_position() - c.get_normal() * 4)
		print(tile_position)
		collider.erase_cell(tile_position)
	
	if collider is Enemy:
		collider.take_hit(1, -c.get_normal() * Enemy.BASE_KNOCKBACK)
	
	destroy()