class_name ChunkReader
extends Object


const CHUNKS_PATH = "res://utilities/chunks"


static func read_chunk_file(file_name: String) -> Chunk:
	# var json_obj  = load("%s/%s".format([CHUNKS_PATH, file_name])) as JSON
	var json_obj  = load("%s/%s" % [CHUNKS_PATH, file_name]) as JSON
	var json_data = json_obj.data as Dictionary
	var chunk = Chunk.new()

	chunk.load(json_data)	

	return chunk
