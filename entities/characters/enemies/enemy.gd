class_name Enemy
extends BaseCharacter


func take_hit(damage := 0, knockback := Vector2.ZERO):
	apply_recoil(knockback, 100)