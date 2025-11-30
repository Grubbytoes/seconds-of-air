class_name ChunkLoader
extends Object

## Responsible for loading the JSON data used to build chunks, 
## then instancing chunk objects based on them on request

const CHUNKS_PATH := "res://utilities/chunks/data"


# The bank of chunks as JSON data
static var _chunk_json_data: Array[JSON] = [
	preload(CHUNKS_PATH + "/soa-chunks1.json"),
	preload(CHUNKS_PATH + "/soa-chunks2.json"),
	preload(CHUNKS_PATH + "/soa-chunks3.json")
]


static func random_chunk() -> Chunk:
	var j = _chunk_json_data.pick_random()
	return build_chunk_from_json(j)


# Builds a chunk from some of the banked JSON data
static func build_chunk_from_json(json: JSON) -> Chunk:
	var chunk = Chunk.new()
	chunk.load(json.data)	
	return chunk