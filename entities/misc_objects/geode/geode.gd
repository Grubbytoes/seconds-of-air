class_name Geode
extends AnimatableBody2D


static func create_geode() -> Geode:
	const packed := preload("res://entities/misc_objects/geode/geode.tscn")
	return packed.instantiate() as Geode