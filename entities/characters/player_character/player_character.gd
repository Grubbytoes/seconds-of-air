extends BaseCharacter

const BASE_MOVE_SPEED = 80
const SHOT_RECOIL_STRENGTH = 35
const BASE_SHOT_VELOCITY = 450

var facing_dir := Vector2.UP
var packed_projectile = preload("res://entities/projectiles/player_projectile/player_projectile.tscn")

var _can_shoot := true


@onready var shot_timer := $ShotTimer as Timer


func _physics_process(delta):
	facing_dir = get_local_mouse_position().normalized()

	action_move(delta)

	# check for shot
	if Input.is_action_pressed("shoot") and _can_shoot:
		shoot()

	apply_drag(delta)
	move_character()


func action_move(delta_time: float):
	var dir = Input.get_vector(
		"action_left",
		"action_right",
		"action_up",
		"action_down"
	)
	character_movement = dir * BASE_MOVE_SPEED


func shoot():
	# shoot projectile
	var new_projectile = packed_projectile.instantiate() as Projectile
	add_sibling(new_projectile)
	new_projectile.launch(position, facing_dir * BASE_SHOT_VELOCITY)

	# recoil
	apply_recoil(-facing_dir * SHOT_RECOIL_STRENGTH * 2, SHOT_RECOIL_STRENGTH)

	# start cooldown
	_can_shoot = false
	shot_timer.start()


func _shot_timer_timeout():
	_can_shoot = true


func _on_pickup_area_body_entered(body):
	pass # Replace with function body.
