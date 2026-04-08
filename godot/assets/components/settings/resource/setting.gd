@tool

class_name Setting
extends Resource

@export var display_name := ""
@export var key_name := ""
@export var section_name := "default"
@export var default_value: Variant
@export var apply_setting: GDScript

@export var description := ""

func _init() -> void:
	if key_name == "":
		key_name = display_name.to_snake_case()
	
	if display_name == "":
		display_name = key_name.capitalize()

func get_value() -> Variant:
	return Settings.config.get_value(section_name, key_name, default_value)

func set_value(value: Variant) -> void:
	assert(not Engine.is_editor_hint())
	
	print("Setting set: ", display_name, value)
	Settings.config.set_value(section_name, key_name, value)
	Settings.save()
	apply()

func apply() -> void:
	if apply_setting == null: return
	if not apply_setting.has_method("apply_setting"): push_error("Invalid script")
	print("Setting applied: ", display_name)
	apply_setting.apply_setting(get_value())
