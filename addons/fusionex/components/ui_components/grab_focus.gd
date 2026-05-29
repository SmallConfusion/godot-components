## Calls grab_focus() on its holder on ready and on enter tree. Expects
## `component_holder` to be a [Control].

class_name GrabFocus
extends Component

func _ready() -> void:
	super._ready()
	tree_entered.connect(_grab_focus)
	_grab_focus()

func _grab_focus() -> void:
	var control: Control = component_holder
	control.grab_focus()
