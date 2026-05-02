class_name ArrayIterator
extends Iterator

var underlying: Array
var i := 0

func _next_one() -> Variant:
	if len(underlying) <= i:
		return null
	
	var value: Variant = underlying[i]
	i += 1
	return value

func _init(p_underlying: Array) -> void:
	underlying = p_underlying
