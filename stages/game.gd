class_name Game
extends Node2D

var loaded_levels := {
	"main": preload("res://stages/levels/main_level.tscn")
}
var currentLevel: Node2D

@onready var ui_layer: CanvasLayer =$UILayer


func _ready():
	load_level("main")


func load_level(level_name: String):
	var new_level = loaded_levels.get(level_name) as PackedScene

	if not new_level:
		printerr("Level %s does not exist or has not been loaded" % level_name)
		return

	if currentLevel:
		currentLevel.queue_free()
	
	currentLevel = new_level.instantiate()
	add_child(currentLevel)