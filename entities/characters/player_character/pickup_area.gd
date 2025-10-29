# Made using Hugos basic script template!

# class_name
extends Area2D

# Members here - remember SECEPPO!!


func body_entered_area(other: Node2D):
	if other is BaseCollectable:
		pick_up_collectable(other)
	
	
func pick_up_collectable(c: BaseCollectable):
	print("picked up collectable")
	c.on_pickup()