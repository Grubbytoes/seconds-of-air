class_name ChunkLoader
extends Object


const CHUNKS_PATH = "res://utilities/chunks/data"


# The bank of chunks as JSON data
static var _chunk_data := {
	Chunk.Opening.LEFT: [
		# preload("%s/test_chunk.json" % CHUNKS_PATH)
	],
	Chunk.Opening.CENTER: [
		preload("%s/test_chunk.json" % CHUNKS_PATH)
	],
	Chunk.Opening.RIGHT: [
		# preload("%s/test_chunk.json" % CHUNKS_PATH)
	],
}

static func random_chunk_by_opening(opening := Chunk.Opening.CENTER):
	var r = (randi() % 2 == 0)

	if r and opening == Chunk.Opening.LEFT:
		opening = Chunk.Opening.RIGHT
	elif r and opening == Chunk.Opening.RIGHT:
		opening = Chunk.Opening.LEFT
	
	var chunk_json = _chunk_data[opening].pick_random()
	var new_chunk = build_chunk_from_json(chunk_json)
	new_chunk.flipped_h = r
	return new_chunk


# Builds a chunk from some of the banked JSON data
static func build_chunk_from_json(json: JSON) -> Chunk:
	var chunk = Chunk.new()
	chunk.load(json.data)	
	return chunk
