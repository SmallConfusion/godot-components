class_name QuitButton
extends Button

func _ready() -> void:
	if OS.has_feature("web"):
		visible = false
	
	pressed.connect(get_tree().quit)
