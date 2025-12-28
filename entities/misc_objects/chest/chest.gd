class_name Chest
extends StaticBody2D

@export var drop_gems := 8

var health := 3
var opened = false

var _i := false
var _i_timer: Timer

@onready var anim := $Anim as AnimationPlayer
@onready var star_particles := $StartParticles as GPUParticles2D


func _ready():
	_i_timer = Timer.new()
	_i_timer.wait_time = .3
	_i_timer.one_shot = true

	add_child(_i_timer)

	_i_timer.timeout.connect(stop_invincibility)


func trigger_body_entered(body:Node2D) -> void:
	if opened: 
		return
	
	if body.is_in_group("player"):
		open()
		

func open():
	opened = true
	anim.play("open")
	set_collision_layer_value(1, false)

	SoundManager.play_sound("object_hit")


func release():
	var release_motion = Vector2(0, 50)
	var angle = 2 * PI / drop_gems
	var parent = get_parent()

	for i in range(drop_gems):
		Gem.drop_random(parent, position, release_motion, 0, 0.5)
		release_motion = release_motion.rotated(angle)

	star_particles.restart()
	
	SoundManager.play_sound("chest_open")


func take_hit(damage := 0, _knockback := Vector2.ZERO):
	if _i:
		return

	health -= damage

	if health <= 0:
		kill()
		SoundManager.play_sound("object_kill")
	else:
		start_invincibility(1)
		SoundManager.play_sound("object_hit")


func start_invincibility(t := 1):
	_i = true
	_i_timer.start(t)
	anim.play("hit")


func stop_invincibility():
	_i = false
	anim.play("RESET")


func kill():
	if randi() % 2:
		var new_bubble = AirBubble.PACKED_BUBBLE.instantiate()
		new_bubble.position = self.position + Vector2.LEFT * 16
		add_sibling(new_bubble)
	if randi() % 2:
		var new_bubble = AirBubble.PACKED_BUBBLE.instantiate()
		new_bubble.position = self.position + Vector2.RIGHT * 16
		add_sibling(new_bubble)
	
	queue_free()


static func create_random_chest() -> Chest:
	var packed: PackedScene

	if randf() < 0.75:
		packed = preload("res://entities/misc_objects/chest/green_chest.tscn")
	else:
		packed = preload("res://entities/misc_objects/chest/red_chest.tscn")
	
	return packed.instantiate()
