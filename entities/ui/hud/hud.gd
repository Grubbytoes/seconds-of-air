class_name HUD
extends Control

@export var air_label: Label
@export var score_label: Label


func update_air(value):
	var thing = [floor(value / 60), value % 60]
	air_label.text = "AIR : %02d:%02d" % thing


func update_score(value):
	score_label.text = "SCORE : %06d" % value
