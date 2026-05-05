@tool
extends Node

const PREMULTIPLIED_ALPHA = preload("uid://bpv5vjk32086k")

func _ready() -> void:
	get_tree().node_added.connect(_set_material)

func _set_material(node: Node) -> void:
	if (
		not(
			node is Sprite2D or
			node is AnimatedSprite2D or 
			node is TextureRect
		) or
		node.material != null or
		node.owner == null
	): return
	
	node.material = PREMULTIPLIED_ALPHA
