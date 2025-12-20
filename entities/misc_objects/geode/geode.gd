class_name Geode
extends StaticBody2D


@export var motion := Vector2.ZERO
@export var damping := 5.0
@export var bounce := 0.5
@export var richness := 8

@onready var sprite := $Sprite as AnimatedSprite2D

func _physics_process(delta):
	move(delta)


func hit(normal := Vector2.ZERO):
	if richness <= 0:
		return

	const DROP_RADIUS := sqrt(16 * 16 + 16 * 16) + 8
	var drop_parent := get_parent()
	var richness_extracted := 1
	var drop_position := self.position - normal.normalized() * DROP_RADIUS

	if randf() > .5:
		richness_extracted += 1

	Gem.drop_random(drop_parent, drop_position, -normal.normalized() * 50)
	motion += normal * 10
	sprite.play("hit")
	richness -= richness_extracted

	if richness <= 0:
		kill()
		return
		
	SoundManager.play_sound("object_hit")
	

func move(delta: float):
	if motion == Vector2.ZERO:
		return
	
	var k := move_and_collide(motion * delta)

	# bouncing
	if k != null:
		motion = motion.bounce(k.get_normal()) * bounce

	# dampening
	var l = motion.length()
	l = max(0, l - damping * delta)
	motion = motion.normalized() * l


func kill():
	sprite.play("kill")
	sprite.animation_finished.connect(queue_free)


static func create_geode() -> Geode:
	const packed := preload("res://entities/misc_objects/geode/geode.tscn")
	return packed.instantiate() as Geode
