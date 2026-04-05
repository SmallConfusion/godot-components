class_name ComponentHelper
extends RefCounted

## Component must have `get_component_name() -> StringName`
static func set_component(object: Object, component: Object):
	var name: StringName = component.get_component_name()
	
	if object.has_meta(name):
		push_warning("Object ", object, " already has component of name ", name)
	
	object.set_meta(name, component)

static func get_component(object: Object, name: StringName) -> Variant:
	if object.has_meta(name):
		return object.get_meta(name)
	else:
		return null

static func get_component_checked(object: Object, name: StringName) -> Variant:
	var component = get_component(object, name)
	assert(component != null, "Component does not exist")
	return component
