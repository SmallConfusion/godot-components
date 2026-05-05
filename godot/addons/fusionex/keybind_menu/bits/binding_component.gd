class_name BindingComponent
extends HBoxContainer

const BINDING_COMPONENT = preload("uid://dy8vr1qbrgnf1")

var action: StringName
var event: InputEvent

@onready var label: Label = $Label
@onready var del_button: Button = $DelButton
@onready var change_button: Button = $ChangeButton

static func create(p_action: StringName, p_event: InputEvent) -> BindingComponent:
	var this = BINDING_COMPONENT.instantiate()
	this.action = p_action
	this.event = p_event
	return this

func _ready() -> void:
	del_button.pressed.connect(_remove)
	change_button.pressed.connect(_change)
	_display_key_name()
	
func _display_key_name() -> void:
	label.text = event.as_text()

func _remove() -> void:
	InputMap.action_erase_event(action, event)
	InputMapManager.save()
	queue_free()

func _change() -> void:
	label.text = "Press Key"
	InputMap.action_erase_event(action, event)
	
	var old_button_text := change_button.text
	change_button.text = "..."
	
	event = await InputMapManager.get_next_input()
	
	change_button.text = old_button_text
	_display_key_name()
	
	InputMap.action_add_event(action, event)
	InputMapManager.save()
