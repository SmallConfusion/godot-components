class_name CartesianIterator
extends Iterator

var other_arr: Array[Variant]
var other_iter: Iterator

var base_item: Variant
var base_iter: Iterator

func _init(a: Iterator, b: Iterator) -> void:
	base_iter = a
	base_item = base_iter.next()
	other_arr = b.collect()
	other_iter = ArrayIterator.new(other_arr)

func _next_one() -> Variant:
	if base_item == null:
		return null
	
	var other_next: Variant = other_iter.next()
	
	if other_next == null:
		base_item = base_iter.next()
		other_iter = ArrayIterator.new(other_arr)
		return _next_one()
	
	return [base_item, other_next]
