class_name Enemy
extends BaseCharacter

signal death

@export var health := 1 


func take_hit(damage := 0, knockback := Vector2.ZERO):
	health -= damage

	apply_recoil(knockback)
	
	if health <= 0:
		kill()


func kill():
	death.emit()
	queue_free()