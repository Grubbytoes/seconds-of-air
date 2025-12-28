extends Node

var sound_bank = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for c in get_children():
		var aud = c as AudioStreamPlayer

		if aud == null:
			continue
		
		sound_bank[aud.name.to_snake_case()] = aud
	
func play_sound(key: String):
	var aud = sound_bank.get(key) as AudioStreamPlayer

	if aud == null:
		return
	
	aud.play()