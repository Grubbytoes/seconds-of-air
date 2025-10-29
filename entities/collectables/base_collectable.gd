## The base class for all collectable objects - by default this collectible does nothing and destroys itself when picked up.
## Extends Node2D so can be attached to any 2d node or body.


class_name BaseCollectable
extends Node2D


func on_pickup():
	queue_free()