extends Control

@export var skip_in_editor := true
@export var animation := &"splash"
@export_file("*.tscn", "*.scn") var next: String

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	var err := ResourceLoader.load_threaded_request(next)
	
	if err:
		push_error(err)
	
	if not skip_in_editor and OS.has_feature("editor"):
		animation_player.play(animation)
		await animation_player.animation_finished
	
	var next_scene := ResourceLoader.load_threaded_get(next)
	get_tree().change_scene_to_packed(next_scene)
