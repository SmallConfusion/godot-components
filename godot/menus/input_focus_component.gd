class_name InputFocusComponent
extends Component

func _ready() -> void:
	super._ready()
	(component_holder as Control).grab_focus.call_deferred()
