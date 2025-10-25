# Made using Hugos basic script template!

class_name BaseCharacter
extends CharacterBody2D


var character_movement: Vector2


func move_character() -> bool:
	velocity = character_movement
	return move_and_slide()