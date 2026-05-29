## Hides its holder on ready if the feature tag is present.

class_name HideOnFeature
extends Component

@export var feature := "web"

func _ready() -> void:
	super._ready()
	
	if OS.has_feature(feature):
		var visible_holder: CanvasItem = component_holder
		visible_holder.visible = false
