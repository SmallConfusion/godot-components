@abstract
class_name Component3D
extends Node3D

@export var component_holder: Node

@abstract
func get_component_name() -> StringName

func get_component(object: Object) -> Variant:
	return ComponentHelper.get_component(object, get_component_name())

func get_component_checked(object: Object) -> Variant:
	return ComponentHelper.get_component_checked(object, get_component_name())

func _ready() -> void:
	if component_holder == null:
		component_holder = get_parent()
	
	ComponentHelper.set_component(component_holder, self)
