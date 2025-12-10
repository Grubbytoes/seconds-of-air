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


func launch(launch_position := Vector2.ZERO, launch_velocity := Vector2.ZERO, spread = 0.0) -> void:
	var lifetime_timer := get_tree().create_timer(lifetime)
	position = launch_position
	velocity = launch_velocity
	launched = true

	lifetime_timer.timeout.connect(destroy)

	if spread > 0:
		velocity = velocity.rotated(randf() * spread - spread / 2)


func contact(_c: KinematicCollision2D):
	destroy()


func destroy():
	destroyed.emit()
	queue_free()