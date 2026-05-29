@tool

class_name Setting
extends Resource

## The name used when displaying the setting for the user in a [FusionSettingDisplay].
## Can be left empty and key_name will be used with automatic capitalization.
@export var display_name := ""

## The name used for the key in the setting file. Can be left empty and display_name
## will be used with automatic snake casing.
@export var key_name := ""

## The section in the setting file to store this in. This doesn't really matter to the user.
@export var section_name := "default"

@export var default_value: Variant

## This needs to be a script with a `static func apply_setting(value: Variant) -> void`
@export var apply_setting: GDScript

## This is used for the hover tooltip when attached to a [FusionSettingDisplay].
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
