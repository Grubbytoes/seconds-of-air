class_name IntArray2d
extends Object

## A simple 2d integer array.
## One may visualize the axis as x going left to right, and y going top to bottom, equivalent to space in a 2D Godot scene

var _inner_array := PackedInt32Array()

## The width of the array, or length of a single row
var width := 0
## The height or depth of the array
var height := 0
## The total number of spaces in the array. Equal to width * height, and the length of the core array
var area: int:
	get:
		return width * height
	set(v):
		printerr("%s.area is read only" % self)

func _init(new_width, new_height, default := 0):
	width = new_width
	height = new_height
	_inner_array.resize(area)
	_inner_array.fill(default)


## Gets the item at the given Vector2i coordinate
func getv(v: Vector2i) -> int:
	var i = v_to_i(v)
	
	return _inner_array[i]


## Sets the value at the given Vector2i coordinate
func setv(v: Vector2i, val: int):
	var i = v_to_i(v)
	
	_inner_array[i] = val


func get_row(idx: int) -> PackedInt32Array:
	return _inner_array.slice(idx * width, (idx + 1) * width)


func get_column(idx: int) -> PackedInt32Array:
	var column = PackedFloat32Array()
	column.resize(height)

	for i in range(height):
		column[i] = _inner_array[i * width + idx]

	return column


## Converts a Vector2i coordinate to a usable integer index
func v_to_i(v: Vector2i) -> int:
	if not is_valid_coord(v):
		printerr("vector %s is out of bounds for IntArray2d(%s, %s)" % [v, width, height])
		return -1

	return v.y * width + v.x


## Converts an integer index to the equivalent Vector2i for this array
func i_to_v(i: int) -> Vector2i:
	var x = i % width
	var y = (i - x) / width
	return Vector2i(x, y)


## Returns whether or not the given Vector2i is a valid coordinate
## IE 0 <= x < width and 0 <= y < height
func is_valid_coord(v: Vector2i):
	if v.x < 0 or width <= v.x:
		return false
	elif v.y < 0 or height <= v.y:
		return false

	return true


## Creates a copy of the array, and returns it
func duplicate() -> IntArray2d:
	var duplicated := IntArray2d.new(width, height)

	for v in coords():
		duplicated.setv(v, getv(v))
	
	return duplicate()


## Returns a copy of the array, flipped along the y axis
func flippedh() -> IntArray2d:
	var flipped := IntArray2d.new(width, height)
	var flipped_v: Vector2i

	for v in coords():
		flipped_v = Vector2i(width - v.x, v.y)
		flipped.setv(flipped_v, getv(v))
	
	return flipped


## Returns a copy of the array, flipped along the x axis
func flippedv() -> IntArray2d:
	var flipped := IntArray2d.new(width, height)
	var flipped_v: Vector2i

	for v in coords():
		flipped_v = Vector2i(v.x, height - v.y)
		flipped.setv(flipped_v, getv(v))
	
	return flipped


# Returns a copy of the array, rotated r steps, where each step is 90 degrees
func rotated90(r := 1) -> IntArray2d:
	r %= 4
	var rotated: IntArray2d
	var rotated_v: Vector2i

	if r == 0:
		rotated = self.duplicate()
	elif r == 1:
		rotated = IntArray2d.new(height, width)
		for v in coords():
			rotated_v = Vector2i(-v.y, v.x)
			rotated.setv(rotated_v, getv(v))
	elif r == 2:
		rotated = IntArray2d.new(width, height)
		for v in coords():
			rotated_v = Vector2i(width - v.x, height - v.y)
			rotated.setv(rotated_v, getv(v))
	elif r == 3:
		rotated = IntArray2d.new(height, width)
		for v in coords():
			rotated_v = Vector2i(v.y, -v.x)
			rotated.setv(rotated_v, getv(v))

	return rotated		


## Returns a copy of all values in this array, this is equivalent to traversing the array top left to bottom right 
func values() -> PackedInt32Array:
	return _inner_array.duplicate()


## Returns an iterator of all possible Vector2i coordinates for this array
func coords():
	return VIterator.new(width, height)
	

## Iterator class for vectors, roughly equivalent to a nested for loop
class VIterator:
	var value: Vector2i
	var width: int
	var height: int

	func _init(w, h):
		width = w
		height = h 

	func _iter_init(_iter: Array) -> bool:
		value = Vector2i.ZERO

		return true
	
	func _iter_get(_iter: Variant) -> Variant:
		return value
	
	func _iter_next(_iter: Array) -> bool:
		value.x += 1

		if 0 == value.x % width:
			value.x = 0
			value.y += 1
		
		return height > value.y