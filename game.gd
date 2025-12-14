class_name Game
extends Node2D

static var _loaded_stages := {
	"game stage" = load("res://stages/levels/main_level.tscn"),
	"main menu" = load("res://stages/menus/main/main_menu.tscn"),
	"results menu" = load("res://stages/menus/results_display/results_display.tscn")
}

var current_stage: Stage
var results_cache: SessionResults

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
	new_stage.attach_game(self)
	current_stage = new_stage
	add_child(new_stage)


func cache_results(r: SessionResults):
	results_cache = r


func get_cached_results() -> SessionResults:
	return results_cache


func store_results() -> bool:
	if results_cache == null:
		return false
	
	# todo
	return true