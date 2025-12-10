extends Projectile

# * OVERRIDE
func contact(c: KinematicCollision2D):
	var collider = c.get_collider()

	if collider is TerrainTileMap:
		var tile_position = collider.local_to_map(c.get_position() - c.get_normal() * 4)
		collider.destroy_tile(tile_position)
	elif collider is Enemy and collider.is_alive():
		collider.take_hit(1, -c.get_normal() * Enemy.BASE_KNOCKBACK)
	elif collider is Chest:
		collider.take_hit(1)
	
	destroy()