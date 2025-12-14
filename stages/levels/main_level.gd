extends Stage


func on_session_end(results: SessionResults):
    queue_next_stage("main menu")
    get_game().cache_results(results)
    queue_next_stage("results menu")