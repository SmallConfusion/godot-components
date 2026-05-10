class_name Components
extends RefCounted

## A helper function for setting the component on a node.
## Component must have `NAME: StringName`.
static func set_component(object: Object, component: Object):
	var name: StringName = component.NAME
	
	if object.has_meta(component.NAME):
		push_warning("Object ", object, " already has component of name ", component.NAME)
	
	object.set_meta(name, component)
	
	if component.has_signal("tree_exiting"):
		object.tree_exiting.connect(func():
			object.remove_meta(component.NAME)
		)

## Gets the component on the object, or returns null if it doesn't exist.
static func get_on(object: Object, name: StringName) -> Variant:
	if object.has_meta(name):
		return object.get_meta(name)
	else:
		return null
