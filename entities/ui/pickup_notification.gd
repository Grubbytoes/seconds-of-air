class_name PickupNotification
extends Node2D

const PACKED := preload("res://entities/ui/pickup_notification.tscn")

var motion := Vector2.UP * 32

@onready var label: Label = $Label


func _ready():
	display_number(0)


func _process(delta):
	position += motion * delta


func display_number(i := 0):
	var text = "%03d" % i
	label.text = text


func display_text(text := "NONE"):
	label.text = text


func set_colour(c: Color):
	modulate = c
