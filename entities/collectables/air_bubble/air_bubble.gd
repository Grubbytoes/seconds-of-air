extends BaseCollectable

@export var air_value := 5


func on_pickup():
	super.on_pickup()
	GlobalEvents.add_air.emit(air_value)