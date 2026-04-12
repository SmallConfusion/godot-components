@tool

extends CanvasLayer

signal finished

@export var transition_set: ScreenTransitionSet = preload("uid://2grwx77qo4l4")
@onready var texture_rect: TextureRect = $TextureRect

var tween: Tween

func _ready() -> void:
	visible = false

func change_scene(scene: String) -> void:
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
