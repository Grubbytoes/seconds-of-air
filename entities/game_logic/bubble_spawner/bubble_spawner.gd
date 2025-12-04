extends Node2D

const _PACKED_BUBBLE = preload("res://entities/collectables/air_bubble/air_bubble.tscn")

@onready var timer: Timer = $Timer


func _ready():
	start_timer()


func spawn_bubble():
	print("spawn bubble")

	var new_bubble = _PACKED_BUBBLE.instantiate()
	new_bubble.position = random_position()
	add_child(new_bubble)

	start_timer()


func start_timer():
	var t = randf() * 8 + 24
	timer.start(t)


func random_position() -> Vector2:
	var p = Vector2(0, 250)
	p.x += randi_range(2, 22) * 16
	return p