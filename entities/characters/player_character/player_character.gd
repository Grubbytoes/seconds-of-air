extends BaseCharacter

signal damage_taken

const BASE_MOVE_SPEED = 120
const SHOT_RECOIL_STRENGTH = 10
const BASE_SHOT_VELOCITY = 450

var facing_dir := Vector2.UP
var packed_projectile = preload("res://entities/projectiles/player_projectile/player_projectile.tscn")

var _can_shoot := true
var _can_move := true


@onready var shot_timer := $ShotTimer as Timer


func _physics_process(delta):
	facing_dir = get_local_mouse_position().normalized()

	action_move(delta)

	# check for shot
	if Input.is_action_pressed("shoot") and _can_shoot:
		shoot()

	apply_drag(delta)
	move_character()


# * override
func take_hit(damage := 0, knockback := Vector2.ZERO):
	apply_recoil(knockback)
	GlobalEvents.add_air.emit(-damage)
	damage_taken.emit()
	
	# inefficient replace later
	_can_move = false
	var t:= get_tree().create_timer(.25)
	t.timeout.connect(func(): _can_move = true)


func action_move(delta_time: float):
	if not _can_move:
		character_movement = Vector2.ZERO
		return
	
	var dir = Input.get_vector(
		"action_left",
		"action_right",
		"action_up",
		"action_down"
	) * BASE_MOVE_SPEED
	
	if dir != Vector2.ZERO:
		character_movement = dir
	elif character_movement.length() > 1:
		character_movement = character_movement.move_toward(dir, 8 * BASE_MOVE_SPEED * delta_time)
	else:
		character_movement = Vector2.ZERO


func shoot():
	# shoot projectile
	var new_projectile = packed_projectile.instantiate() as Projectile
	add_sibling(new_projectile)
	new_projectile.launch(position, facing_dir * BASE_SHOT_VELOCITY)

	# start cooldown
	_can_shoot = false
	shot_timer.start()


func _shot_timer_timeout():
	_can_shoot = true
