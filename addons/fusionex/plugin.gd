@tool
extends EditorPlugin

const BUTLER_SETTING := "fusionex/butler_path"

func _enable_plugin() -> void:
	add_autoload_singleton("Settings", "res://addons/fusionex/settings/settings.tscn")
	add_autoload_singleton("InputMapManager", "res://addons/fusionex/keybind_menu/input_map_manager.gd")
	
	if AudioServer.bus_count == 1:
		AudioServer.add_bus()
		AudioServer.add_bus()
		
		AudioServer.set_bus_name(1, "Sfx")
		AudioServer.set_bus_name(2, "Music")
		
		var limiter := AudioEffectHardLimiter.new()
		limiter.resource_name = "HardLimiter"
		AudioServer.add_bus_effect(0, limiter)
	
	var es := EditorInterface.get_editor_settings()
	
	if !es.has_setting(BUTLER_SETTING):
		es.set_setting(BUTLER_SETTING, "butler")

func _disable_plugin() -> void:
	remove_autoload_singleton("Settings")
	remove_autoload_singleton("InputMapManager")

func _enter_tree() -> void:
	pass

func _exit_tree() -> void:
	clear_commands()

var added_commands := []
func add_command(display_name: String, callable: Callable) -> void:
	var cp := EditorInterface.get_command_palette()
	var key_name := display_name.to_snake_case()
	cp.add_command(display_name, key_name, callable)
	added_commands.push_back(key_name)

func clear_commands() -> void:
	var cp := EditorInterface.get_command_palette()
	for command in added_commands:
		cp.remove_command(command)
