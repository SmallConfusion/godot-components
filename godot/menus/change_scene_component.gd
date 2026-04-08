class_name ChangeSceneComponent
extends Component

@export_file("*.tscn", "*.scn") var scene: String

func _ready() -> void:
	super._ready()
	
	var change_scene := get_tree().change_scene_to_file.bind(scene)
	var button: Button = self.component_holder
	button.pressed.connect(change_scene)
