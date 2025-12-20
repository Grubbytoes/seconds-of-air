extends Node2D

signal char_offscreen_timeout

var char_offscreen := false

@export var char: BaseCharacter
@export var offscreen_time_allowed := 3

@onready var screen_notifier := VisibleOnScreenNotifier2D.new()
@onready var timer := $Timer as Timer
@onready var arrow_sprite := $ArrowSprite as AnimatedSprite2D

func _ready():
	char.add_child(screen_notifier)
	screen_notifier.screen_entered.connect(char_entered_screen)
	screen_notifier.screen_exited.connect(char_exited_screen)

	timer.wait_time = offscreen_time_allowed


func _physics_process(delta):
	if not char_offscreen:
		return
	
	arrow_sprite.position.x = char.position.x


func char_entered_screen():
	print(" * char entered screen")
	timer.stop()
	char_offscreen = false
	arrow_sprite.visible = false


func char_exited_screen():
	timer.start()
	char_offscreen = true
	arrow_sprite.visible = true

	if global_position.direction_to(char.position).y > 0:
		arrow_sprite.play("down")
		arrow_sprite.position.y = 190
	else:
		arrow_sprite.play("up")
		arrow_sprite.position.y = 26


# ! JANK!! opens up all sort of problems were we to continue working...!
# func _exit_tree() -> void:
# 	screen_notifier.queue_free()


func on_timer_timeout() -> void:
	char_offscreen_timeout.emit()
