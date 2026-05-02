class_name RangeIterator
extends Iterator

var i: int
var step: int
var end: int

func _init(p_start: int, p_end: int, p_step := 1) -> void:
	i = p_start
	end = p_end
	step = p_step

static func unended(p_start := 0, p_step := 1) -> RangeIterator:
	var end_value: int
	
	if p_step > 0:
		end_value = INT32_MAX
	else:
		end_value = INT32_MIN
	
	return RangeIterator.new(p_start, end_value, p_step)

static func to(p_end: int, p_step := 1) -> RangeIterator:
	return RangeIterator.new(0, p_end, p_step)

func _next_one() -> Variant:
	if sign(end - i) != sign(step):
		return null
	
	var r := i
	i += step
	return r
