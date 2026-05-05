class_name BackButton
extends Component

func _ready() -> void:
	super._ready()
	var button: Button = self.component_holder
	button.pressed.connect(SceneManager.back)
