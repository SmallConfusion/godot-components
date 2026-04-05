class_name KeybindMenu
extends Control

@onready var action_component_container: VBoxContainer = %ActionComponentContainer
@onready var reset_button: Button = $ActionComponentContainer/ResetButton

func _ready() -> void:
	_create_components()
	
	reset_button.pressed.connect(
		func() -> void:
			InputMap.load_from_project_settings()
			InputMapManager.save()
			
			for child in action_component_container.get_children():
				if child is ActionBindComponent:
					child.queue_free()
			
			_create_components()
	)


func _create_components() -> void:
	for action in InputMapManager.get_user_actions():
		var component := ActionBindComponent.create(action)
		action_component_container.add_child(component)
