@tool

extends Node

const FILEPATH := "user://settings.cfg"
var config := ConfigFile.new()

@export var apply_on_load: Array[Resource] = []

func _ready() -> void:
	if FileAccess.file_exists(FILEPATH):
		config.load(FILEPATH)

func save() -> void:
	config.save(FILEPATH)
