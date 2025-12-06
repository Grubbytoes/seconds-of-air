extends Enemy

enum State {
	BASE,
	STUN
}

@export var look_ahead := 24
@export var move_speed := 50

var move_dir = Vector2.LEFT
var state := State.BASE

@onready var sight_ray: RayCast2D = $SightRay
@onready var stun_timer: Timer = $StunTimer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite

func _ready():
	if randi() % 2:
		move_dir = Vector2.RIGHT
	
	sight_ray.target_position = move_dir * look_ahead
	stun_timer.timeout.connect(end_stun)


func _physics_process(delta):
	if state == State.BASE:
		if sight_ray.is_colliding() or get_slide_collision_count():
			bounce()
		velocity = move_dir * move_speed
	elif state == State.STUN:
		pass
		
	move_and_slide() 


# * OVERRIDE
func take_hit(damage := 0, knockback := Vector2.ZERO):
	super.take_hit(damage)
	
	if !is_alive():
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


func end_stun():
	state = State.BASE
	sprite.play("default")


func bounce():
	move_dir = move_dir.reflect(Vector2.DOWN)
	sight_ray.target_position = move_dir * look_ahead
