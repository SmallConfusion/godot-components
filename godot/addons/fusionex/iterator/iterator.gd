## Rust style iterator for godot.

@abstract
class_name Iterator

var pipe := Pipe.new()

## Override this function to create a custom iterator. It should return the next
## value or null if it is empty.
@abstract
func _next_one() -> Variant

## Gets the next value from the iterator, or null if there are no more values.
func next() -> Variant:
	while true:
		var n = _next_one()
		
		if n == null:
			return null
		
		var transformed = pipe.pipe(n)
		
		if transformed != null:
			return transformed
	
	return null

## This also functions as a filter map. f is a [Callable] that returns the new element,
## or null if it should be skipped.
func map(f: Callable) -> Iterator:
	pipe.add_action(f)
	return self

## f is a [Callable] that takes the value and returns true if we keep this value or false if not.
func filter(f: Callable) -> Iterator:
	return map(
		func(v: Variant) -> Variant:
			if f.call(v): return v
			else: return null
	)

## Converts an iterator of iterators to an iterator over their values.
func flatten() -> FlattenedIterator:
	return FlattenedIterator.new(self)

## Same as reduce on [Array]
func reduce(method: Callable, accum: Variant = null) -> Variant:
	var n: Variant = next()
	
	while n != null:
		accum = method.call(accum, n)
		n = next()
	
	return accum

## Converts an iterator to an array of its values.
func collect() -> Array[Variant]:
	var array := []
	
	for_each(func(value: Variant) -> void:
		array.push_back(value))
	
	return array

## Returns the first value that when passed to f, returns true.
func find(f: Callable) -> Variant:
	while true:
		var n: Variant = next()
		
		if n == null:
			return null
		
		if f.call(n):
			return n
	
	return null

## Ignores the next n elements.
func skip(amount: int) -> Iterator:
	for i in amount:
		next()
	
	return self

## Returns an iterator of arrays of this paired with each element of the other iterator.
func cartesian_product(other: Iterator) -> CartesianIterator:
	return CartesianIterator.new(self, other)

## Returns an iterator of arrays with the values [index, element].
func enumerate() -> ParallelIterator:
	return ParallelIterator.new([RangeIterator.unended(), self])

## Appends the other iterator to the end of this one.
func chain(other: Iterator) -> ChainIterator:
	return ChainIterator.new(self, other)

## Calls a function on each value of the iterator.
func for_each(f: Callable) -> void:
	var n: Variant = next()
	
	while n != null:
		f.call(n)
		n = next()
