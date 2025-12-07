class_name Chest
extends Node2D

@export var drop_gems := 12

@onready var anim := $Anim as AnimationPlayer
@onready var star_particles := $StartParticles as GPUParticles2D


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
