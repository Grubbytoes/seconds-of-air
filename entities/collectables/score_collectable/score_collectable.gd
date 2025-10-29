extends BaseCollectable

@export var score_value := 5


func on_pickup():
	GlobalEvents.add_score.emit(score_value)
	queue_free()