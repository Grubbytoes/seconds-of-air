class_name SessionMaster
extends Node
## Responsible for managing the logic of a single 'run' or session of the game
## Designed to be the single point of reference for resources, time, score etc.
## As well as a central point of contact for communications (player to ui etc) and signals to minimize coupling

signal time_tick()
signal session_ended(results: SessionResults)
signal score_update(new_score: int)
signal time_update(new_time: int)
signal air_update(new_air: int)

@export var initial_air := 180

var time := 0
var air := 0
var score := 0
var results: SessionResults

@onready var tick_timer: Timer = $TickTimer


func _enter_tree() -> void:
	GlobalEvents.add_air.connect(add_air)
	GlobalEvents.add_score.connect(add_score)


func _ready():
	air = initial_air
	tick_timer.timeout.connect(tick)
	tick_timer.start(1)

	# Update with initial air
	air_update.emit(air)


func add_score(s: int):
	score += s
	score_update.emit(score)


func add_air(a: int):
	air += a
	air_update.emit(air)


func tick():
	time += 1
	air -= 1

	time_tick.emit()
	time_update.emit(time)
	air_update.emit(air)

	if 0 >= air:
		end_game()
	else:
		tick_timer.start(1)


func end_game():
	tick_timer.stop()

	results = SessionResults.new()

	results.score = score
	results.time = time
	session_ended.emit(results)