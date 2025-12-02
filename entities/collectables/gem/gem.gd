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


# * OVERRIDE
func on_pickup():
	super.on_pickup()
	GlobalEvents.add_score.emit(get_value())


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

