extends Node2D

enum ScrollMode {
	HALT,
	NORMAL,
	FAST
}

@export var char: BaseCharacter
@export var scroll_speed := 16
@export var enable_camera := true

var scroll_mode := ScrollMode.NORMAL
var scroll_velocity := Vector2.ZERO

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


func bottom_area_entered(body:Node2D):
	if body == char:
		scroll_mode = ScrollMode.FAST


func bottom_area_exited(body:Node2D):
	if body == char:
		scroll_mode = ScrollMode.NORMAL


func top_area_entered(body:Node2D):
	if body == char:
		scroll_mode = ScrollMode.HALT


func top_area_exited(body:Node2D):
	if body == char:
		scroll_mode = ScrollMode.NORMAL
