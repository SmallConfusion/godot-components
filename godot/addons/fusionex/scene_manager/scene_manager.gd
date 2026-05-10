@tool

extends CanvasLayer

signal finished

@onready var texture_rect: TextureRect = $TextureRect

var tween: Tween

var scene_stack: Array[Node] = []

func _ready() -> void:
	visible = false

## Clears the stack of scenes to go back to.
func clear_stack() -> void:
	scene_stack = []

func back() -> void:
	if len(scene_stack) == 0:
		push_warning("Can't go back when there is no previous scene")
		return
	
	var scene: Node = scene_stack.pop_back()
	get_tree().change_scene_to_node(scene)

## The change scene function. Use this to change scenes.
func change_scene(scene: String, transition_set: ScreenTransitionSet = preload("uid://2grwx77qo4l4")) -> void:
	ResourceLoader.load_threaded_request(scene)
	visible = true
	
	texture_rect.material.set_shader_parameter("between", transition_set.between)
	
	if tween != null: tween.kill()
	
	if transition_set.forwards.transition_length != 0:
		_setup_transition(transition_set.forwards)
		
		tween = create_tween()
		tween.tween_method(
			set_shader_t, 0.0, 1.0, transition_set.forwards.transition_length
		)
		await tween.finished
	
	var old_scene := get_tree().current_scene
	get_tree().root.remove_child(old_scene)
	scene_stack.push_back(old_scene)
	
	get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(scene))
	
	if transition_set.backwards.transition_length != 0:
		_setup_transition(transition_set.backwards)
		
		tween = create_tween()
		tween.tween_method(
			set_shader_t, 1.0, 0.0, transition_set.backwards.transition_length
		)
		await tween.finished
	
	visible = false
	finished.emit()

func set_shader_t(x: float) -> void:
	texture_rect.material.set_shader_parameter("t", x)

func _setup_transition(transition: ScreenTransition) -> void:
	texture_rect.texture = transition.transition_image
	texture_rect.material.set_shader_parameter("fuzz", transition.fuzz)
	texture_rect.material.set_shader_parameter("invert", transition.invert)
