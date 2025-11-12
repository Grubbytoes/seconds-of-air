class_name BaseCollectable
extends Node2D

func on_pickup():
	var anim := $SimpleEffectsPlayer as AnimationPlayer
	anim.play("fade")
	anim.animation_finished.connect(queue_free.unbind(1))