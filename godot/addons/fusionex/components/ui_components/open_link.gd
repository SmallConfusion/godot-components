## To be attached to a [RichTextLabel]. It will open urls and probably other things.

class_name OpenLink
extends Component

func _ready() -> void:
	super._ready()
	
	var label: RichTextLabel = component_holder
	label.meta_clicked.connect(OS.shell_open)
