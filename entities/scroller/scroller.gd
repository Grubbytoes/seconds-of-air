extends Node2D

@export var char: BaseCharacter
@export var scroll_speed := 64
@export var enable_camera := true

@onready var camera: Camera2D = get_node("MainCamera")

func _ready():
	camera.enabled = enable_camera


func _physics_process(delta):
	var move_by = Vector2(0, scroll_speed) * delta
	position += move_by
	char.move_and_collide(move_by)
