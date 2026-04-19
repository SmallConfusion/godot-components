class_name ChangeSceneComponent
extends Component

@export_file("*.tscn", "*.scn") var scene: String
@export var transition: ScreenTransitionSet = preload("uid://2grwx77qo4l4")

func _ready() -> void:
	super._ready()
	
	var change_scene: Callable = SceneManager.change_scene.bind(scene, transition)
	var button: Button = self.component_holder
	button.pressed.connect(change_scene)
