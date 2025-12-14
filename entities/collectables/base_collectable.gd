class_name BaseCollectable
extends StaticBody2D

@export var motion := Vector2.ZERO
@export var damping := 5.0
@export var bounce := 0.5


func on_pickup():
	queue_free()


func move(delta : float):
	if motion == Vector2.ZERO:
		return
	
	var k := move_and_collide(motion * delta)

	if k != null:
		motion = motion.bounce(k.get_normal()) * bounce

	# dampening
	var l = motion.length()
	l = max(0, l - damping * delta)
	motion = motion.normalized() * l