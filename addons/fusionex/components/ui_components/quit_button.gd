## Quits the game. Expects component_holder to be a [Button].

class_name QuitButton
extends Component

func _ready() -> void:
	super._ready()
	var button: Button = component_holder
	button.pressed.connect(get_tree().quit)
