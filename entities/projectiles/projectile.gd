class_name Projectile
extends StaticBody2D


signal destroyed

@export var lifetime := 5.0

var velocity := Vector2.ZERO
var launched := false


func _physics_process(delta):
	var c := move_and_collide(velocity * delta)

	if c:
		contact(c)


func launch(launch_position := Vector2.ZERO, launch_velocity := Vector2.ZERO) -> void:
	position = launch_position
	velocity = launch_velocity
	launched = true

	var lifetime_timer := get_tree().create_timer(lifetime)
	lifetime_timer.timeout.connect(destroy)


func contact(c: KinematicCollision2D):
	var collider = c.get_collider()

	if collider is TileMapLayer:
		var tile_position = collider.local_to_map(c.get_position() - c.get_normal() * 4)
		print(tile_position)
		collider.erase_cell(tile_position)
	
	if collider is Enemy:
		collider.take_hit(1, -c.get_normal() * 40)

	destroy()


func destroy():
	destroyed.emit()
	queue_free()