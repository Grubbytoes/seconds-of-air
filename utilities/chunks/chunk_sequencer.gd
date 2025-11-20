class_name ChunkSequencer
extends Object

static var chunk_pool = {
	Chunk.Opening.LEFT: [],
	Chunk.Opening.CENTER: [],
	Chunk.Opening.RIGHT: [],
}

var prev_chunk: Chunk
var current_chunk: Chunk
	

# returns the next chunk, and updates current/prev chunk
func next_chunk() -> Chunk:
	var new_chunk := chunk_from_pool(current_chunk.bottom_opening)

	prev_chunk = current_chunk
	current_chunk = new_chunk
	
	return current_chunk


func chunk_from_pool(opening := Chunk.Opening.CENTER) -> Chunk:
	var flip = (randi() % 2 == 0)
	return null