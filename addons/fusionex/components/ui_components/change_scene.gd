## Hooks into [SceneManager] to change scenes. Expects `component_holder` to be
## a [Button].

class_name ChangeScene
extends Component

@export_file("*.tscn", "*.scn") var scene: String

func _ready() -> void:
	super._ready()
	var button: Button = self.component_holder
	button.pressed.connect(get_tree().change_scene_to_file.bind(scene))
