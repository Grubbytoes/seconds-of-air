extends Stage

@export var score_label: Label
@export var time_label: Label
@export var bonus_label: Label
@export var final_score_label: Label


func _ready():
	var r := get_game().get_cached_results()
	score_label.text = "%06d" % r.raw_score
	time_label.text = "%02d:%02d" % [floor(r.time / 60), r.time % 60]

	if r.short_time_bonus > 0:
		bonus_label.visible = true
		bonus_label.text += "SHORT TIME BONUS : %s" % r.short_time_bonus
	
	if r.long_time_bonus > 0:
		bonus_label.text += ", LONG TIME BONUS : %s" % r.long_time_bonus

	final_score_label.text = "%06d" % r.final_score


func on_menu_button_pressed() -> void:
	queue_next_stage("main menu")


func on_play_again_button_pressed() -> void:
	queue_next_stage("game stage")
