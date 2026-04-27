class_name GrabFocus
extends Component

func _ready() -> void:
	super._ready()
	
	var control: Control = component_holder
	control.grab_focus()
