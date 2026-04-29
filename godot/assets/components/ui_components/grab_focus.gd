class_name GrabFocus
extends Component

func _ready() -> void:
	super._ready()
	tree_entered.connect(_grab_focus)
	_grab_focus()

func _grab_focus() -> void:
	var control: Control = component_holder
	control.grab_focus()
