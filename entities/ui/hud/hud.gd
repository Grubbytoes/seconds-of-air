class_name HUD
extends Control

@export var air_label: Label
@export var score_label: Label


func update_air(value):
	var as_minutes = [floor(value / 60), value % 60]
	air_label.text = "AIR : %03d (%02d:%02d)" % [value, as_minutes[0], as_minutes[1]]


func update_score(value):
	score_label.text = "SCORE : %06d" % value
