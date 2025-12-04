class_name Enemy
extends BaseCharacter

signal death

@export var health := 1 
@export var contact_damage := 1


# * OVERRIDE
func take_hit(damage := 0, _knockback := Vector2.ZERO):
	health = max(0, health - damage)

	if !is_alive():
		kill()


## does nothing by default, made to be overridden
func kill():
	death.emit()


func on_contact(body: Node2D):
	# player contact damage
	if body.is_in_group("player") and body is BaseCharacter:
		var normal = self.position.direction_to(body.position)
		body.take_hit(contact_damage, normal * BASE_KNOCKBACK)
	

func is_alive() -> bool:
	return 0 < health