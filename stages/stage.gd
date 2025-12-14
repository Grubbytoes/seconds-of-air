class_name Stage
extends Node

var _game: Game


func attach_game(game: Game):
	if _is_attached():
		printerr("Game already attached")
	else:
		_game = game


func queue_next_stage(stage_key: String):
	get_game().load_stage(stage_key)


func get_game():
	return _game


func _is_attached() -> bool:
	return _game != null
