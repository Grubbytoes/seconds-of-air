class_name ChunkReader
extends Object


const CHUNKS_PATH = "res://utilities/data/chunks"


static func read_chunk_file(file_name: String) -> JSON:
	# var json_obj  = load("%s/%s".format([CHUNKS_PATH, file_name])) as JSON
	var json_obj  = load("res://utilities/data/chunks/test_chunk.json") as JSON
	return json_obj