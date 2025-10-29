# class_name
extends Area2D


func body_entered_area(other: Node2D):
	if other is BaseCollectable:
		pick_up_collectable(other)
	
	
func pick_up_collectable(c: BaseCollectable):
	c.on_pickup()