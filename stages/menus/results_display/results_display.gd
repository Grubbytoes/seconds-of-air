extends Stage

@export var score_label: Label
@export var time_label: Label


func _ready():
	var r := get_game().get_cached_results()
	score_label.text = "%06d" % r.score
	time_label.text = "%02d:%02d" % [floor(r.time / 60), r.time % 60]


func on_menu_button_pressed() -> void:
	queue_next_stage("main menu")


func on_play_again_button_pressed() -> void:
	queue_next_stage("game stage")
