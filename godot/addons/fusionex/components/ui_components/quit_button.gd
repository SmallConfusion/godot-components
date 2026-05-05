class_name QuitButton
extends Component

func _ready() -> void:
	super._ready()
	var button: Button = component_holder
	button.pressed.connect(get_tree().quit)
