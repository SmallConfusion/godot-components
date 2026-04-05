@tool
extends EditorPlugin

var autoloads: Array[Array] = [
    ["InputMapManager", "./keybind_menu/input_map_manager.gd"],
    ["Settings", "./settings/settings.gd"],
]


func _enable_plugin():
    for autoload in autoloads:
        add_autoload_singleton(autoload[0], autoload[1])


func _disable_plugin():
    for autoload in autoloads:
    	remove_autoload_singleton(autoload[0])
