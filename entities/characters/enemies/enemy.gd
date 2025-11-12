class_name Enemy
extends BaseCharacter

signal death

@export var health := 1 

@onready var anim: AnimationPlayer = $SimpleEffectsPlayer

func take_hit(damage := 0, knockback := Vector2.ZERO):
	health -= damage

	apply_recoil(knockback)
	anim.play("flash")
	
	if health <= 0:
		kill()


func kill():
	anim.play("fade")
	anim.animation_finished.connect(queue_free.unbind(1))