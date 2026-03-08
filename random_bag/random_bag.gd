class_name RandomBag
extends Resource

signal bag_refilled

@export var choices := []

var _bag := []

static func with_bag(items: Array) -> RandomBag:
	var new := RandomBag.new()
	new.choices = items
	return new

static func with_choices(...values: Array) -> RandomBag:
	return with_bag(values)

## Creates a bag. Items is Array[[element: Variant, count: int]]
static func with_count(items: Array) -> RandomBag:
	var new := RandomBag.new()
	
	for item in items:
		var element: Variant = item[0]
		var count: int = item[1]
		
		for _i in count:
			new.choices.push_back(element)
	
	return new

func pick() -> Variant:
	if len(_bag) == 0:
		refill_bag()
	
	return _bag.pop_back()

func refill_bag() -> void:
	_bag = choices.duplicate()
	_bag.shuffle()
	bag_refilled.emit()
