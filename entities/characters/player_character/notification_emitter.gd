extends Node2D

@onready var _parent := get_parent() as Node2D

func _ready():
	GlobalEvents.add_score.connect(score_notification)
	GlobalEvents.add_air.connect(air_notification)


func score_notification(s):
	var c = PickupNotification.PACKED.instantiate()
	c.position = _parent.position + (Vector2.UP * 16).rotated(randf() * 2 * PI)
	
	_parent.add_sibling(c)
	c.display_number(s)



func air_notification(s):
	var c = PickupNotification.PACKED.instantiate()
	c.position = _parent.position + (Vector2.UP * 16).rotated(randf() * 2 * PI)
	
	_parent.add_sibling(c)
	c.display_number(s)

	if s < 0:
		c.set_colour(Color.hex(0xcc425eff))
	else:
		c.set_colour(Color.hex(0x6d80faff))
