class_name ParallelIterator
extends Iterator

var iterators: Array[Iterator]

func _init(p_iterators: Array[Iterator] = []) -> void:
	iterators = p_iterators

func _next_one() -> Variant:
	var final_value := []
	
	for iterator in iterators:
		var n: Variant = iterator.next()
		
		if n == null:
			return null
		
		final_value.push_back(n)
	
	return final_value
