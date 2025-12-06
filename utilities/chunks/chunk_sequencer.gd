class_name ChunkSequencer
extends Object
## Fetches chunk objects from the chunk loader, in order to be pieced together in a coherent 
## sequence.

var prev_chunk: Chunk
var chunk_count := 0

# returns the next chunk, and updates previous chunk
func next_chunk() -> Chunk:
	var new_chunk := chunk_from_loader()
	
	prev_chunk = new_chunk
	chunk_count += 1
	
	return new_chunk


# gets a random appropriate chunk from the loader
func chunk_from_loader() -> Chunk:
	var new_chunk = ChunkLoader.random_chunk()
	if (randi() % 2):
		new_chunk.flip_h()
	return new_chunk
