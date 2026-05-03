class_name Component
extends Node

@export var component_holder: Node

func _ready() -> void:
	if component_holder == null:
		component_holder = get_parent()
	
	if self.get("NAME") != null:
		Components.set_component(component_holder, self)
