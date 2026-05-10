## Hooks into [SceneManager] to go back on click. Expects `component_holder` to
## be a [Button].

class_name BackButton
extends Component

func _ready() -> void:
	super._ready()
	var button: Button = self.component_holder
	button.pressed.connect(SceneManager.back)
