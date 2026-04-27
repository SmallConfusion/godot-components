class_name HideOnFeature
extends Component

@export var feature := "web"

func _ready() -> void:
	super._ready()
	if OS.has_feature(feature):
		component_holder.visible = false
