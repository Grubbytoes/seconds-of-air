class_name BaseCharacter
extends CharacterBody2D

# Base drag applied to characters
const BASE_DRAG = 40

const BASE_MAX_RECOIL = 100

## The component of character velocity equivalent to this characters intended direction of movement
var character_movement := Vector2.ZERO

## The component of character velocity equivalent to recoil (from shooting, knockback, etc)
var _recoil_component := Vector2.ZERO


func _physics_process(delta):
	apply_drag(delta)
	move_character()


func move_character(extra_components : Array[Vector2] = []) -> bool:
	velocity = character_movement
	velocity += _recoil_component

	for c in extra_components:
		velocity += c

	return move_and_slide()


## Applies drag
func apply_drag(delta_time: float):
	_recoil_component = _recoil_component.move_toward(Vector2.ZERO, BASE_DRAG * delta_time)


## Applies an impulse to the recoil component
func apply_recoil(max_dir: Vector2, strength: float = BASE_MAX_RECOIL, override := false):
	if override:
		_recoil_component = Vector2.ZERO

	_recoil_component = _recoil_component.move_toward(max_dir, strength)