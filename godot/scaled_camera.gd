class_name ScaledCamera
extends Camera2D

@export var base_zoom := 1.0

func _process(_delta: float) -> void:
	zoom = Vector2.ONE * base_zoom / get_window().content_scale_factor
	
