extends Label
class_name RestartGameLabel

func _ready() -> void:
	visible = false
	
	for node in get_tree().get_nodes_in_group("setting_displays"):
		node.game_restart_required.connect(func(): self.visible = true)
