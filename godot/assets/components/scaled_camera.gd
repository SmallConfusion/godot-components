class_name ScaledCamera
extends Camera2D

@export var real_zoom := 1.0

func _process(_delta: float) -> void:
	var ignore_scale_vec := Vector2(get_window().size) / Vector2(3840, 2160)
	var ignore_scale := minf(ignore_scale_vec.x, ignore_scale_vec.y)
	
	zoom = Vector2.ONE * ignore_scale * real_zoom / get_window().content_scale_factor
