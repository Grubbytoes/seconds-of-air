extends Stage


func on_session_end(results: SessionResults):
	get_game().cache_results(results)
	var callback = queue_next_stage.bind("results menu")
	get_tree().create_timer(2).timeout.connect(callback)
	
