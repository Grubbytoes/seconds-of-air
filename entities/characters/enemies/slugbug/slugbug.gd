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

func _ready():
	if randi() % 2:
		move_dir = Vector2.RIGHT
	sight_ray.target_position = move_dir * look_ahead
	stun_timer.timeout.connect(func(): state = State.BASE)


func _physics_process(delta):
	if state == State.BASE:
		if sight_ray.is_colliding() or get_slide_collision_count():
			bounce()
		velocity = move_dir * move_speed
	elif state == State.STUN:
		apply_drag(delta)
		
	move_and_slide() 


# * override
func take_hit(damage := 0, knockback := Vector2.ZERO):
	super.take_hit(damage, knockback)
	state = State.STUN
	stun_timer.start()


func bounce():
	move_dir = move_dir.reflect(Vector2.DOWN)
	sight_ray.target_position = move_dir * look_ahead
