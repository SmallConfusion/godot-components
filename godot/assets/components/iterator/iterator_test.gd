@tool
extends EditorScript

func _run() -> void:
	print("Running tests")
	
	var array := [1, 2, 6, 8]
	
	var arr_iter := ArrayIterator.new(array)
	assert_eq(arr_iter.next(), 1)
	assert_eq(arr_iter.next(), 2)
	assert_eq(arr_iter.next(), 6)
	assert_eq(arr_iter.next(), 8)
	assert_eq(arr_iter.next(), null)
	
	var map_iter := ArrayIterator.new(array).map(func(v: int) -> bool: return v % 2 == 0)
	
	assert_eq(map_iter.next(), false)
	assert_eq(map_iter.next(), true)
	assert_eq(map_iter.next(), true)
	assert_eq(map_iter.next(), true)
	assert_eq(map_iter.next(), null)
	
	var filter_map := ArrayIterator.new(array).map(func(v: int) -> Variant:
		if v < 3: return null
		else: return v * 3
	)
	
	assert_eq(filter_map.next(), 18)
	assert_eq(filter_map.next(), 24)
	assert_eq(filter_map.next(), null)
	
	var filter := ArrayIterator.new(array).filter(func(v: int) -> bool: return v > 4)
	
	assert_eq(filter.next(), 6)
	assert_eq(filter.next(), 8)
	assert_eq(filter.next(), null)
	
	var range_iter := RangeIterator.to(100)
	var sum = range_iter.reduce(func(accum, num): return accum + num, 0)
	assert_eq(sum, 4950)
	
	var range_2 := RangeIterator.unended(10, -2)
	assert_eq(range_2.next(), 10)
	assert_eq(range_2.next(), 8)
	assert_eq(range_2.next(), 6)
	assert_eq(range_2.next(), 4)
	assert_eq(range_2.next(), 2)
	assert_eq(range_2.next(), 0)
	assert_eq(range_2.next(), -2)
	assert_eq(range_2.next(), -4)
	assert_eq(range_2.next(), -6)
	assert_eq(range_2.next(), -8)
	
	var flat_arr := (RangeIterator.to(5)
		.map(func(i): return RangeIterator.to(i))
		.flatten()
		.collect())
	
	assert_eq(flat_arr, [0, 0, 1, 0, 1, 2, 0, 1, 2, 3])
	
	var cartesian := RangeIterator.new(10, 15).cartesian_product(RangeIterator.new(0, 3))
	assert_eq(cartesian.next(), [10, 0])
	assert_eq(cartesian.next(), [10, 1])
	assert_eq(cartesian.next(), [10, 2])
	assert_eq(cartesian.next(), [11, 0])
	assert_eq(cartesian.next(), [11, 1])
	assert_eq(cartesian.next(), [11, 2])
	assert_eq(cartesian.next(), [12, 0])
	assert_eq(cartesian.next(), [12, 1])
	assert_eq(cartesian.next(), [12, 2])
	assert_eq(cartesian.next(), [13, 0])
	assert_eq(cartesian.next(), [13, 1])
	assert_eq(cartesian.next(), [13, 2])
	assert_eq(cartesian.next(), [14, 0])
	assert_eq(cartesian.next(), [14, 1])
	assert_eq(cartesian.next(), [14, 2])
	assert_eq(cartesian.next(), null)
	
	var repeat := RepeatIterator.new(5)
	assert_eq(repeat.next(), 0)
	assert_eq(repeat.next(), 0)
	assert_eq(repeat.next(), 0)
	assert_eq(repeat.next(), 0)
	assert_eq(repeat.next(), 0)
	assert_eq(repeat.next(), null)
	
	var enumerate := RepeatIterator.new(5).enumerate()
	assert_eq(enumerate.next(), [0, 0])
	assert_eq(enumerate.next(), [1, 0])
	assert_eq(enumerate.next(), [2, 0])
	assert_eq(enumerate.next(), [3, 0])
	assert_eq(enumerate.next(), [4, 0])
	assert_eq(enumerate.next(), null)
	
	print("Done running tests")

static func assert_eq(a: Variant, b: Variant) -> void:
	if a != b:
		print("Assertion failed: %s != %s" % [a, b])
