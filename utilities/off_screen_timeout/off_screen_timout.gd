extends Node2D

signal off_screen_timeout

@export var wait_time = 5
@export var patient = true

@onready var onscreen_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var timer: Timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = wait_time

	if !patient:
		timer.start()


func on_timer_timeout() -> void:
	print("off screen timeout!")
	off_screen_timeout.emit()


func on_screen_exited() -> void:
	print("screen exited")
	timer.start(wait_time)


func on_screen_entered() -> void:
	timer.stop()
