class_name ChunkSequencer
extends Object
## Fetches chunk objects from the chunk loader, in order to be pieced together in a coherent 
## sequence.

var prev_chunk: Chunk
var chunk_count := 0

var _next_chest_at := 3

# returns the next chunk, and updates previous chunk
func next_chunk() -> Chunk:
	var new_chunk: Chunk

	if _next_chest_at == chunk_count:
		new_chunk = chest_chunk_from_loader()
		_next_chest_at += randi_range(4, 6)
		print("created chest chunk!!")
	else:
		new_chunk = chunk_from_loader()
	
	prev_chunk = new_chunk
	chunk_count += 1
	
	return new_chunk


func chest_chunk_from_loader() -> Chunk:
	return ChunkLoader.create_special_chunk("chest") 


# gets a random appropriate chunk from the loader
func chunk_from_loader() -> Chunk:
	var new_chunk = ChunkLoader.create_random_chunk()
	if (randi() % 2):
		new_chunk.flip_h()
	return new_chunk
