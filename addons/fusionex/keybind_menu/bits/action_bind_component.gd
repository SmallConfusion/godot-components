class_name ActionBindComponent
extends VBoxContainer

const ACTION_BIND_COMPONENT = preload("uid://c2k8fqohfo03d")

var action: StringName

@onready var label: Label = $HBoxContainer/Label
@onready var button: Button = $HBoxContainer/Button
@onready var binding_container: VBoxContainer = $BindingContainer

static func create(p_action: StringName) -> ActionBindComponent:
	var this: ActionBindComponent = ACTION_BIND_COMPONENT.instantiate()
	this.action = p_action
	return this

func _ready() -> void:
	button.pressed.connect(_add)
	label.text = action.capitalize()
	
	for event in InputMap.action_get_events(action):
		binding_container.add_child(BindingComponent.create(action, event))

func _add() -> void:
	var old_button_text := button.text
	button.text = "..."
	
	var event := await InputMapManager.get_next_input()
	
	button.text = old_button_text
	
	var c := BindingComponent.create(action, event)
	binding_container.add_child(c)
	binding_container.move_child(c, 0)
	
	InputMap.action_add_event(action, event)
	InputMapManager.save()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(action):
		modulate = Color(0.957, 0.399, 0.608, 1.0)
	
	if event.is_action_released(action):
		modulate = Color.WHITE
