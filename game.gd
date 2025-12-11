class_name Game
extends Node2D

static var _loaded_stages := {
	"game stage" = load("res://stages/levels/main_level.tscn"),
	"main menu" = load("res://stages/menus/main/main_menu.tscn"),
}

var current_stage: Stage

@onready var ui_layer: CanvasLayer =$UILayer


func _ready():
	load_stage("main menu")


func load_stage(stage_key: String):
	var packed_stage := _loaded_stages.get(stage_key) as PackedScene
	var new_stage := packed_stage.instantiate()

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