extends BaseCharacter

signal damage_taken

const MOVE_SPEED = 100
const MOVE_ACCELERATION = 150
const SHOT_RECOIL_STRENGTH = 10
const SHOT_VELOCITY = 450

var facing_dir := Vector2.UP
var packed_projectile = preload("res://entities/projectiles/player_projectile/player_projectile.tscn")
var currently_shooting = false

var _shot_ready := true
var _can_move := true


@onready var shot_timer := $ShotTimer as Timer


func _physics_process(delta):
	var did_move = action_move(delta)
	var did_shoot = action_shoot()
	
	if !did_move:
		apply_drag(delta, .125)

	move_and_slide()


# * override
func take_hit(damage := 0, knockback := Vector2.ZERO):
	apply_recoil(knockback)
	GlobalEvents.add_air.emit(-damage)
	damage_taken.emit()
	
	# inefficient replace later
	_can_move = false
	var t := get_tree().create_timer(.25)
	t.timeout.connect(func(): _can_move = true)


func action_move(delta_time: float) -> bool:
	var dir = Vector2.ZERO

	if not _can_move:
		dir = Vector2.ZERO
	else:
		dir = Input.get_vector(
			"action_left",
			"action_right",
			"action_up",
			"action_down"
		) * MOVE_SPEED
	
	if dir:
		velocity = velocity.move_toward(dir * MOVE_SPEED, MOVE_ACCELERATION * delta_time)
	
	if dir and not currently_shooting:
		facing_dir = dir.normalized()
	
	return dir != Vector2.ZERO


func action_shoot() -> bool:
	currently_shooting = Input.is_action_pressed("action_1")

	# check for shot
	if _shot_ready and currently_shooting:
		shoot()
		return true
	
	return false


func shoot():
	print("pew: %s" % facing_dir)

	# shoot projectile
	var new_projectile = packed_projectile.instantiate() as Projectile
	add_sibling(new_projectile)
	new_projectile.launch(position, facing_dir * SHOT_VELOCITY)

	# start cooldown
	_shot_ready = false
	shot_timer.start()


func _shot_timer_timeout():
	_shot_ready = true
