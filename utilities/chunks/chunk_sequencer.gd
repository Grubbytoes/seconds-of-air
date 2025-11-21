class_name ChunkSequencer
extends Object

var prev_chunk: Chunk

# returns the next chunk, and updates previous chunk
func next_chunk() -> Chunk:
	var new_chunk := chunk_from_loader(prev_chunk.bottom_opening)
	prev_chunk = new_chunk
	return new_chunk


# gets a random appropriate chunk from the loader
func chunk_from_loader(opening := Chunk.Opening.CENTER) -> Chunk:
	return ChunkLoader.random_chunk_by_opening(opening)