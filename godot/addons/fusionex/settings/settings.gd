@tool

extends Node

const SETTING_RESOURCES = ["res://settings", "res://assets/fusionex/settings/presets"]

const FILEPATH := "user://settings.cfg"
var config := ConfigFile.new()

func _ready() -> void:
	if FileAccess.file_exists(FILEPATH):
		config.load(FILEPATH)
	
	for path in SETTING_RESOURCES:
		_init_settings(path)

func save() -> void:
	config.save(FILEPATH)

func _init_settings(path: String) -> void:
	if Engine.is_editor_hint(): return

	var files := DirAccess.get_files_at(path)
	
	for file in files:
		if file.ends_with(".uid"): continue
		
		file = file.replace(".remap", "")
		
		var setting := load(path.path_join(file))
		
		if setting is Setting:
			setting.apply()
	
	var directories := DirAccess.get_directories_at(path)
	
	for dir in directories:
		_init_settings(path.path_join(dir))
