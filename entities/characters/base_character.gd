class_name BaseCharacter
extends CharacterBody2D

signal death

# Base drag applied to characters
const BASE_KNOCKBACK = 120
const BASE_MAX_RECOIL = 100


## does nothing by default, made to be overridden
func take_hit(_damage := 0, _knockback := Vector2.ZERO):
	pass


func apply_drag(delta_time: float, strength := 1.0):
	if velocity.length() <= 2:
		velocity = Vector2.ZERO
	else:
		velocity = velocity.lerp(Vector2.ZERO, delta_time * strength)


## Applies an impulse to the recoil component
func apply_recoil(v: Vector2, override := false):
	if override:
		velocity = Vector2.ZERO
	velocity += v


# TODO kill() could be pulled up
func kill():
	death.emit()