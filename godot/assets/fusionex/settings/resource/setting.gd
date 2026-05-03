@tool

class_name Setting
extends Resource

@export var display_name := ""
@export var key_name := ""
@export var section_name := "default"
@export var default_value: Variant

## This needs to be a script with a `static func apply_setting(value: Variant) -> void`
@export var apply_setting: GDScript

@export var description := ""


func _fix_names() -> void:
	if key_name == "":
		key_name = display_name.to_snake_case()
	
	if display_name == "":
		display_name = key_name.capitalize()

func get_value() -> Variant:
	_fix_names()
	
	return Settings.config.get_value(section_name, key_name, default_value)

func set_value(value: Variant) -> void:
	assert(not Engine.is_editor_hint())
	
	_fix_names()
	
	print("Setting set: %s %s" % [display_name, value])
	Settings.config.set_value(section_name, key_name, value)
	Settings.save()
	apply()

func apply() -> void:
	assert(not Engine.is_editor_hint())
	
	if apply_setting == null: return
	if not apply_setting.has_method("apply_setting"): push_error("Invalid script")
	print("Setting applied: %s" % [display_name])
	apply_setting.apply_setting(get_value())
