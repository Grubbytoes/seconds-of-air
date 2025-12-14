extends BaseCollectable

const AIR_VALUE = 20
const RISE_VELOCITY = 32

@onready var sprite: AnimatedSprite2D = $Sprite

var _sway_clock = 0.0

func _physics_process(delta):
	# TODO incorporate BaseCollectable.move(...)
	_sway_clock += delta * 1.2
	
	position.y -= RISE_VELOCITY * delta
	position.x += (sin(_sway_clock) / 2)

# * OVERRIDE
func on_pickup():
	GlobalEvents.add_air.emit(AIR_VALUE)
	sprite.animation_finished.connect(queue_free, Object.ConnectFlags.CONNECT_ONE_SHOT)
	sprite.play("pop")

