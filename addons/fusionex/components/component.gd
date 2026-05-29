## A component is a node that is attached to another node. If an inheriting class
## has a `const NAME: StringName` then a reference to it can be gotten with
## `Components.get_on(node, NAME)`. NAME can be the same as other classes to
## approximate polymorphism.
class_name Component
extends Node

## The node that this component is attached to. The node that this component is on.
## If this is not set, this is set to its parent.
@export var component_holder: Node

## Component's `_ready()` does some setup and must be called from the inheriting class
## if overridden.
func _ready() -> void:
	if component_holder == null:
		component_holder = get_parent()
	
	if self.get("NAME") != null:
		Components.set_component(component_holder, self)
