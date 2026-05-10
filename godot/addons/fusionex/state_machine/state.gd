## A state machine state. To be used with [StateMachine].

class_name State

@warning_ignore("unused_signal")
signal entered

@warning_ignore("unused_signal")
signal exited

var _enter: Callable
var _tick: Callable
var _exit: Callable

static func _noop() -> void: pass

static func _call_with_maybe_arg(f: Callable, arg: Variant) -> Variant:
	if f.get_unbound_arguments_count() == 0:
		return f.call()
	else:
		return f.call(arg)

## Tick is a callable that takes no arguments.
## Enter is a callable that takes either no arguments or the previous state.
## Exit is a callable that takes either no arguments or the previous state.
func _init(p_tick := _noop, p_enter := _noop, p_exit := _noop) -> void:
	_enter = p_enter
	_tick = p_tick
	_exit = p_exit

func enter(previous_state: State) -> void:
	_call_with_maybe_arg(_enter, previous_state)
	entered.emit()

func exit(next_state: State) -> void:
	_call_with_maybe_arg(_exit, next_state)
	exited.emit()

func tick() -> void:
	_tick.call()
