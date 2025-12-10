class_name Chest
extends Node2D

@export var drop_gems := 8

var health := 3

var _i := false
var _i_timer: Timer

@onready var anim := $Anim as AnimationPlayer
@onready var star_particles := $StartParticles as GPUParticles2D


func _ready():
	_i_timer = Timer.new()
	_i_timer.one_shot = true

	add_child(_i_timer)

	_i_timer.timeout.connect(stop_invincibility)


func trigger_body_entered(body:Node2D) -> void:
	if body.is_in_group("player"):
		start_open()
		

func start_open():
	anim.play("open")


func release():
	var release_motion = Vector2(0, 50)
	var angle = 2 * PI / drop_gems
	var parent = get_parent()

	for i in range(drop_gems):
		Gem.drop_random(parent, position, release_motion, 0, 0.5)
		release_motion = release_motion.rotated(angle)

	star_particles.restart()


func take_hit(damage := 0, _knockback := Vector2.ZERO):
	if _i:
		return

	health -= damage
	start_invincibility(1)


func start_invincibility(t := 1):
	_i = true
	_i_timer.start(t)
	anim.play("hit")


func stop_invincibility():
	_i = false
	anim.play("RESET")

	if health <= 0:
		queue_free()