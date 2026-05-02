class_name RepeatIterator
extends Iterator

var i := 0
var count: int
var value: Variant = 0

func _init(p_count: int, p_value: Variant = 0) -> void:
	count = p_count
	value = p_value

static func forever(value: Variant = 0) -> RepeatIterator:
	return RepeatIterator.new(INT64_MAX, value)

func _next_one() -> Variant:
	if i >= count:
		return null
	
	i += 1
	return value
