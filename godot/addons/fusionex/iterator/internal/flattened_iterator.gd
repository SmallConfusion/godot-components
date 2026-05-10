class_name FlattenedIterator
extends Iterator

var underlying: Iterator
var current: Iterator = EmptyIterator.new()

func _init(p_underlying: Iterator) -> void:
	underlying = p_underlying

func _next_one() -> Variant:
	var current_next: Variant = current.next()
	
	if current_next != null:
		return current_next
	
	current = underlying.next()
	
	if current == null:
		return null
	
	return _next_one()
