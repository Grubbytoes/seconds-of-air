extends Node2D

enum ScrollMode {
	HALT,
	NORMAL,
	FAST
}

@export var char: BaseCharacter
@export var scroll_speed := 64
@export var enable_camera := true

var scroll_mode := ScrollMode.NORMAL

@onready var camera: Camera2D = get_node("MainCamera")

func _ready():
	camera.enabled = enable_camera


func _physics_process(delta):
	var move_by = Vector2(0, scroll_speed) * delta

	if scroll_mode == ScrollMode.HALT:
		return
	elif scroll_mode == ScrollMode.FAST:
		move_by *= 2.5

	position += move_by
	char.move_and_collide(move_by)



func bottom_boundry_body_entered(body:Node2D):
	if body == char:
		scroll_mode = ScrollMode.FAST


func bottom_boundry_body_exited(body:Node2D):
	if body == char:
		scroll_mode = ScrollMode.NORMAL
