@abstract
class_name Iterator

var pipe := Pipe.new()

@abstract
func _next_one() -> Variant

func next() -> Variant:
	while true:
		var n = _next_one()
		
		if n == null:
			return null
		
		var transformed = pipe.pipe(n)
		
		if transformed != null:
			return transformed
	
	return null

## This also functions as filter_map
func map(f: Callable) -> Iterator:
	pipe.add_action(f)
	return self

## f is a Callable that takes the value and returns true if we keep this value or false if not.
func filter(f: Callable) -> Iterator:
	return map(
		func(v: Variant) -> Variant:
			if f.call(v): return v
			else: return null
	)

func flatten() -> FlattenedIterator:
	return FlattenedIterator.new(self)

## Same as `Array.reduce()`
func reduce(method: Callable, accum: Variant = null) -> Variant:
	var n: Variant = next()
	
	while n != null:
		accum = method.call(accum, n)
		n = next()
	
	return accum

func collect() -> Array[Variant]:
	var array := []
	
	for_each(func(value: Variant) -> void:
		array.push_back(value))
	
	return array

func find(f: Callable) -> Variant:
	while true:
		var n: Variant = next()
		
		if n == null:
			return null
		
		if f.call(n):
			return n
	
	return null

func skip(amount: int) -> Iterator:
	for i in amount:
		next()
	
	return self

func cartesian_product(other: Iterator) -> CartesianIterator:
	return CartesianIterator.new(self, other)

func enumerate() -> ParallelIterator:
	return ParallelIterator.new([RangeIterator.unended(), self])

func chain(other: Iterator) -> ChainIterator:
	return ChainIterator.new(self, other)

func for_each(f: Callable) -> void:
	var n: Variant = next()
	
	while n != null:
		f.call(n)
		n = next()
