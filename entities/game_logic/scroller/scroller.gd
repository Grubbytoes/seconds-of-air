extends Node2D

signal scrolled_chunk_length

enum ScrollMode {
	HALT,
	NORMAL,
	FAST
}

@export var char: BaseCharacter
@export var scroll_speed := 16
@export var enable_camera := true
@export var dynamic_scroll_speed := true

var scroll_mode := ScrollMode.NORMAL
var scroll_velocity := Vector2.ZERO
var _scroll_measure := 0.0

@onready var camera: Camera2D = get_node("MainCamera")

func _ready():
	camera.enabled = enable_camera


func _physics_process(delta):
	if scroll_mode == ScrollMode.HALT:
		scroll_velocity.y = move_toward(scroll_velocity.y, 0, scroll_speed * delta)
	elif scroll_mode == ScrollMode.FAST:
		scroll_velocity.y = move_toward(scroll_velocity.y, scroll_speed * 2, scroll_speed * delta)
	else:
		scroll_velocity.y = move_toward(scroll_velocity.y, scroll_speed, scroll_speed * delta)

	position += scroll_velocity * delta
	char.move_and_collide(scroll_velocity * delta)
	foo(scroll_velocity.y * delta)


func foo(delta_y):
	const CHUNK_LENGTH = 24 * 16

	_scroll_measure += delta_y

	if _scroll_measure >= CHUNK_LENGTH:
		scrolled_chunk_length.emit()
		_scroll_measure -= CHUNK_LENGTH
		print("ping!")


func bottom_area_entered(body:Node2D):
	if !dynamic_scroll_speed:
		return
		
	if body == char:
		scroll_mode = ScrollMode.FAST


func bottom_area_exited(body:Node2D):
	if !dynamic_scroll_speed:
		return
		
	if body == char:
		scroll_mode = ScrollMode.NORMAL


func top_area_entered(body:Node2D):
	if !dynamic_scroll_speed:
		return
		
	if body == char:
		scroll_mode = ScrollMode.HALT


func top_area_exited(body:Node2D):
	if !dynamic_scroll_speed:
		return
		
	if body == char:
		scroll_mode = ScrollMode.NORMAL
