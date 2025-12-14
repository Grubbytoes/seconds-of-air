class_name ChunkLoader
extends Object

## Responsible for loading the JSON data used to build chunks, 
## then instancing chunk objects based on them on request

const CHUNKS_PATH := "res://utilities/chunks/data"


# The bank of chunks as JSON data
static var _chunk_json: Array[JSON] = [
	preload(CHUNKS_PATH + "/soa-chunks1.json"),
	preload(CHUNKS_PATH + "/soa-chunks2.json"),
	preload(CHUNKS_PATH + "/soa-chunks3.json"),
	preload(CHUNKS_PATH + "/soa-chunks4.json"),
	preload(CHUNKS_PATH + "/soa-chunks5.json"),
	preload(CHUNKS_PATH + "/soa-chunks6.json"),
	preload(CHUNKS_PATH + "/soa-chunks7.json"),
	preload(CHUNKS_PATH + "/soa-chunks8.json"),
	preload(CHUNKS_PATH + "/soa-chunks9.json"),
]

static var _special_chunk_json: Dictionary[String, JSON] = {
	"chest" : preload(CHUNKS_PATH + "/soa-chest.json")
}


static func create_random_chunk() -> Chunk:
	var j = _chunk_json.pick_random()
	return create_chunk(j)


# Builds a chunk from some of the banked JSON data
static func create_chunk(json: JSON) -> Chunk:
	var chunk = Chunk.new()
	chunk.load(json.data)	
	return chunk


static func create_special_chunk(key: String) -> Chunk:
	var json := _special_chunk_json.get(key) as JSON

	if json == null:
		return Chunk.create_empty()
	else:
		return create_chunk(json)