extends Node2D


func _process(delta):
	position = get_global_mouse_position()


func _enter_tree():
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


func _exit_tree():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
