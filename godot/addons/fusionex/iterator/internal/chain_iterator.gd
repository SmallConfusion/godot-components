class_name ChainIterator
extends Iterator

var iter_a: Iterator
var iter_b: Iterator

func _init(a: Iterator, b: Iterator) -> void:
	iter_a = a
	iter_b = b

func _next_one() -> Variant:
	var a: Variant = iter_a.next()
	
	if a == null:
		return iter_b.next()
	
	return a
