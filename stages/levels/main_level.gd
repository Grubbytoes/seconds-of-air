extends Stage


func on_session_end(results: SessionResults):
    queue_next_stage("main menu")