extends Chest

@export var air_damage := 10

# * override
func trigger_body_entered(body:Node2D) -> void:
	if opened:
		return
	
	if body.is_in_group("player"):
		open()
		var knockback = position.direction_to(body.position) * BaseCharacter.BASE_KNOCKBACK * 2
		(body as BaseCharacter).take_hit(air_damage, knockback)