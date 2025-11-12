class_name Enemy
extends BaseCharacter

signal death

@export var health := 1 
@export var contact_damage := 1

@onready var anim: AnimationPlayer = $SimpleEffectsPlayer

# * override
func take_hit(damage := 0, knockback := Vector2.ZERO):
	health -= damage

	apply_recoil(knockback)
	anim.play("flash")
	
	if health <= 0:
		kill()


func kill():
	anim.play("fade")
	death.emit()
	anim.animation_finished.connect(queue_free.unbind(1))


func on_contact(body: Node2D):

	# player contact damage
	if body.is_in_group("player") and body is BaseCharacter:
		var normal = self.position.direction_to(body.position)
		body.take_hit(contact_damage, normal * BASE_KNOCKBACK)