extends Enemy

# TODO a lot of stuff is copied from slugbug so some super class pulling out is in order

enum State {
	BASE,
	STUN,
	CHASE
}

@export var move_speed := 50

var chase_target: Node2D
var state := State.BASE

@onready var sprite: AnimatedSprite2D = $AnimatedSprite
@onready var stun_timer: Timer = $StunTimer

func _ready():
	stun_timer.timeout.connect(end_stun)


func _physics_process(delta):
	if !is_alive():
		velocity = Vector2.ZERO
	if state == State.CHASE:
		velocity = self.position.direction_to(chase_target.position) * move_speed
	else:
		apply_drag(delta)
	
	move_and_slide()


# * OVERRIDE
func take_hit(damage := 0, knockback := Vector2.ZERO):
	super.take_hit(damage, knockback)
	
	if !is_alive():
		return
	elif state == State.STUN:
		return

	sprite.play("hit")
	state = State.STUN
	stun_timer.start()


# * OVERRIDE
func kill():
	super.kill()
	# queue_free()
	sprite.play("kill")
	sprite.animation_finished.connect(queue_free, Object.ConnectFlags.CONNECT_ONE_SHOT)


func activate_chase(target: Node2D):
	chase_target = target
	state = State.CHASE


func stop_chase():
	chase_target = null
	state = State.BASE


func activation_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		activate_chase(body)


func on_activation_area_body_exited(body: Node2D) -> void:
	if body == chase_target:
		stop_chase()


func end_stun():
	sprite.play("default")
	if chase_target != null:
		state = State.CHASE
	else:
		state = State.BASE
