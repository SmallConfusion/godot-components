extends Node

const SAVEFILE = "user://keymap"

func _load() -> void:
	var file := FileAccess.open(SAVEFILE, FileAccess.READ)
	
	if file == null:
		print("No keymap file found, using defaults")
		return
	
	for action in get_user_actions():
		InputMap.action_erase_events(action)
	
	var current_action: StringName = file.get_var()
	
	while file.get_length() > file.get_position():
		var n = file.get_var(true)
		
		if n is StringName:
			current_action = n
			continue
		
		var event: InputEvent = n
		InputMap.action_add_event(current_action, event)

func save() -> void:
	var file := FileAccess.open(SAVEFILE, FileAccess.WRITE)
	
	for action in get_user_actions():
		file.store_var(action)
		
		for event in InputMap.action_get_events(action):
			file.store_var(event, true)
	
	file.close()

func get_user_actions() -> Array[StringName]:
	return InputMap.get_actions().filter(
		func(x: StringName) -> bool: return !x.begins_with("ui_")
	)

func _ready() -> void:
	_load()

signal _valid_input
var _last_input: InputEvent
var is_waiting := false

func get_next_input() -> InputEvent:
	is_waiting = true
	await _valid_input
	is_waiting = false
	return _last_input

func _input(event: InputEvent) -> void:
	if not is_waiting: return
	if not event.is_pressed(): return
	if not (
		event is InputEventJoypadButton or
		event is InputEventJoypadMotion or
		event is InputEventKey
	): return
	
	get_viewport().set_input_as_handled()

	_last_input = event
	_valid_input.emit()
