class_name Pause
extends CanvasLayer

var is_paused := false

func _on_resume_pressed() -> void:
	visible = false
	get_tree().paused = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"Pause"):
		visible = not visible
		get_tree().paused = visible

func _exit_tree() -> void:
	get_tree().paused = false

func _enter_tree() -> void:
	get_tree().paused = visible
