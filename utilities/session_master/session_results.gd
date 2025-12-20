class_name SessionResults
extends Resource

var raw_score := 0 
var time := 0
var final_score := 0
var short_time_bonus := 0
var long_time_bonus := 0

func calculate_final_score():    
    var extra_time = max(0, time - 100)
    short_time_bonus = (extra_time / 5)
    long_time_bonus = (extra_time / 30)

    final_score = 0
    final_score += raw_score
    final_score *= floor(1.0 + short_time_bonus * 0.1)
    final_score *= floor(1.0 * 1.1 ** long_time_bonus)