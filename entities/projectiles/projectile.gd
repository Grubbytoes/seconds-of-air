# Made using Hugos basic script template!

class_name Projectile
extends Node2D

# Members here - remember SECEPPO!!

@export var lifetime := 5.0

var velocity := Vector2.ZERO
var launched := false


func _physics_process(delta):
	position += velocity * delta


func launch(launch_position := Vector2.ZERO, launch_velocity := Vector2.ZERO) -> void:
	position = launch_position
	velocity = launch_velocity
	launched = true

	var lifetime_timer := get_tree().create_timer(lifetime)
	lifetime_timer.timeout.connect(destroy)


func destroy():
	print("destroying projectile")
	queue_free()

