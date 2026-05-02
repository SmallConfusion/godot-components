class_name Pipe

var actions: Array[Variant] = []

func _init(p_actions: Array[Variant] = []):
	actions = p_actions

func add_action(action: Callable) -> void:
	actions.push_back(action)

func pipe(value: Variant) -> Variant:
	var running: Variant = value
	
	for f in actions:
		if running == null:
			return null
		
		running = f.call(running)
	
	return running
