class_name Game
extends Node2D

const GAME_STAGE := preload("res://stages/levels/main_level.tscn")
const MAIN_MENU := preload("res://stages/menus/main/main_menu.tscn")

var current_stage: Stage

@onready var ui_layer: CanvasLayer =$UILayer


func _ready():
	load_stage(MAIN_MENU)


func load_stage(packed_stage: PackedScene):
	var new_stage := packed_stage.instantiate() as Stage

	# checking validity of new stage
	if not new_stage:
		printerr("invalid stage")
		return
	
	# freeing old stage
	if current_stage:
		current_stage.queue_free()
	
	# setting up new stage
	add_child(new_stage)
	new_stage.attach_game(self)
	current_stage = new_stage