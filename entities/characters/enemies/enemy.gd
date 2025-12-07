class_name Enemy
extends BaseCharacter

signal death

@export var health := 1 
@export var contact_damage := 1
@export var drop_gems := 0


# * OVERRIDE
func take_hit(damage := 0, knockback := Vector2.ZERO):
	health = max(0, health - damage)

	apply_recoil(knockback)

	if !is_alive():
		kill()


## emits death signal and triggers drop
func kill():
	death.emit()
	# TODO handle multiple gems
	for i in range(drop_gems):
		Gem.drop_random(get_parent(), position, Vector2(50, 0), 2 * PI) 


# TODO wtf is going on here
func on_contact(body: Node2D):
	# player contact damage
	if body.is_in_group("player") and body is BaseCharacter:
		var normal = self.position.direction_to(body.position)
		body.take_hit(contact_damage, normal * BASE_KNOCKBACK)
	

func is_alive() -> bool:
	return 0 < health