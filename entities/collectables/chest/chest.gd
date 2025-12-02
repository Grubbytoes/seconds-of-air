class_name Chest
extends Node2D

@onready var anim := $Anim as AnimationPlayer
@onready var star_particles := $StartParticles as GPUParticles2D


func start_open():
	anim.play("open")


func release():
	star_particles.restart()
