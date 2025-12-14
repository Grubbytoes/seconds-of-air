class_name Gem
extends BaseCollectable

enum Type {
	TOPAZ = 0,
	SAPPHIRE,
	EMERALD,
	RUBY,
	DIAMOND
}

@export var type: Type = Type.TOPAZ

@onready var sprite: AnimatedSprite2D = $Sprite


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_sprite_animation()


func _physics_process(delta):
	move(delta)
	

# * OVERRIDE
func on_pickup():
	GlobalEvents.add_score.emit(get_value())
	sprite.animation_finished.connect(queue_free, Object.ConnectFlags.CONNECT_ONE_SHOT)
	sprite.play("pop")


func update_sprite_animation():
	var anim_name = "topaz"

	if type == Type.TOPAZ:
		anim_name = "topaz"
	elif type == Type.SAPPHIRE:
		anim_name = "sapphire"
	elif type == Type.EMERALD:
		anim_name = "emerald"
	elif type == Type.RUBY:
		anim_name = "ruby"
	elif type == Type.DIAMOND:
		anim_name = "diamond"
	
	sprite.play(anim_name)


func get_value() -> int:
	if type == Type.TOPAZ:
		return 5
	elif type == Type.SAPPHIRE:
		return 10
	elif type == Type.EMERALD:
		return 20
	elif type == Type.RUBY:
		return 50
	elif type == Type.DIAMOND:
		return 100
	
	return 0


static func drop_random(drop_parent: Node2D, drop_position: Vector2, initial_motion := Vector2.ZERO, spread := 0.0, ghost_period := 0.5) -> void:
	var d = Gem.create_random_gem()
	d.position = drop_position
	d.motion = initial_motion

	if spread > 0:
		var r = randf() * spread - spread / 2
		d.motion = d.motion.rotated(r)

	if ghost_period > 0:
		var timer = drop_parent.get_tree().create_timer(ghost_period)

		d.set_collision_layer_value(5, false)
		timer.timeout.connect(d.set_collision_layer_value.bind(5, true))
	
	drop_parent.add_child(d)


static func create_random_gem() -> Gem:
	var r = randi() % 31
	const PACKED := preload("res://entities/collectables/gem/gem.tscn")
	var g := PACKED.instantiate()

	if r < 1:
		g.type = Type.DIAMOND
	elif r < 3:
		g.type = Type.RUBY
	elif r < 7:
		g.type = Type.EMERALD
	elif r < 15:
		g.type = Type.SAPPHIRE
	else: # r < 31
		g.type = Type.TOPAZ
	
	return g
