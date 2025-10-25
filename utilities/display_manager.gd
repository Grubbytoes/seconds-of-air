extends Node

var _fullscreen = false

func _process(delta):
	if Input.is_action_just_pressed("toggle_fullscreen"):
		toggle_fullscreen()


func toggle_fullscreen():
	_fullscreen = !_fullscreen
	
	if _fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN) 
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED) 