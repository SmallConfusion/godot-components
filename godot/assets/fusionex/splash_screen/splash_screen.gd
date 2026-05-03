extends Node2D

@export var skip_in_editor := true
@export var animation := &"splash"
@export_file("*.tscn", "*.scn") var next: String

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	if not skip_in_editor and OS.has_feature("editor"):
		animation_player.play(animation)
		await animation_player.animation_finished
	
	SceneManager.change_scene(next)
