extends BaseCharacter

signal damage_taken

enum PlayerState {
	IDLE,
	MOVE,
	SHOOT,
	DASH
}

const MOVE_SPEED = 125
const MOVE_ACCELERATION = 200
const SHOT_RECOIL_STRENGTH = 10
const SHOT_VELOCITY = 350
const SHOT_PERIOD = .2

static var packed_projectile = preload("res://entities/projectiles/player_projectile/player_projectile.tscn")

var current_state := PlayerState.IDLE

var _thrust_dir := Vector2.DOWN
var _facing_dir := Vector2.DOWN
var _shot_ready := true
var _can_move := true

@onready var shot_timer := $ShotTimer as Timer

@export var crosshair: Node2D

func _physics_process(delta):
	action_move(delta)
	apply_drag(delta, .2)
	action_shoot()
	turn_face(delta)

	move_and_slide()


func action_move(delta_time: float):
	if not _can_move:
		return

	var input_vector = Input.get_vector(
		"action_left",
		"action_right",
		"action_up",
		"action_down"
	)

	if input_vector:
		_thrust_dir = input_vector.normalized()
		current_state = PlayerState.MOVE
		velocity = velocity.move_toward(_thrust_dir * MOVE_SPEED, MOVE_ACCELERATION * delta_time)
	else:
		current_state = PlayerState.IDLE
	

func action_shoot():
	if Input.is_action_pressed("action_1"):
		current_state = PlayerState.SHOOT

	# check for shot
	if _shot_ready and current_state == PlayerState.SHOOT:
		shoot()


func shoot():
	# shoot projectile
	var new_projectile = packed_projectile.instantiate() as Projectile
	add_sibling(new_projectile)
	new_projectile.launch(position, _facing_dir * SHOT_VELOCITY)
	apply_recoil(-_facing_dir * SHOT_RECOIL_STRENGTH)

	# start cooldown
	_shot_ready = false
	shot_timer.start(SHOT_PERIOD)


func turn_face(delta: float):
	const SNAP = deg_to_rad(1)

	if current_state != PlayerState.SHOOT:
		_facing_dir = _thrust_dir

	if crosshair:
		crosshair.position = crosshair.position.slerp(_facing_dir * 64, delta * 10)


# * override
func take_hit(damage := 0, knockback := Vector2.ZERO):
	apply_recoil(knockback)
	GlobalEvents.add_air.emit(-damage)
	damage_taken.emit()
	
	# inefficient replace later
	_can_move = false
	var t := get_tree().create_timer(.25)
	t.timeout.connect(func(): _can_move = true)


func _shot_timer_timeout():
	_shot_ready = true
