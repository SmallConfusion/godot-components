class_name StateMachine

signal change_state(old: State, new: State)

var _state: State

func _init(initial_state: State) -> void:
	enter(initial_state)

func enter(state: State) -> void:
	var prev := _state
	
	if _state != null:
		_state.exit(state)
	
	_state = state
	_state.enter(prev)
	change_state.emit(prev, _state)

func tick() -> void:
	_state.tick()
