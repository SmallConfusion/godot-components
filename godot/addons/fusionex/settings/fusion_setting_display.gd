@tool

## Automatically sets up and connects a ui element for the setting resource.
## Currently cannot really be customized very well.

class_name FusionSettingDisplay
extends HBoxContainer

signal game_restart_required
signal value_changed(value: Variant)

@export var setting: Setting:
	set(x): setting = x; _ready()

@export var logarithmic_range := false
@export var require_game_restart := false
@export var value_display := ""
@export var range_step := 0.01

var node: Node

func _ready() -> void:
	add_to_group("setting_displays")
	
	if require_game_restart:
		value_changed.connect(func(_x): game_restart_required.emit())
	
	if node:
		node.queue_free()
	
	if setting is ListSetting:
		var list := OptionButton.new()
	
		var id_values : Array[Variant] = []
		var default_id := -1
		
		for i in len(setting.option_names):
			if setting.get_value() == setting.option_values[i]:
				default_id = i
			
			id_values.push_back(setting.option_values[i])
			list.add_item(setting.option_names[i], i)
		
		if default_id == -1:
			push_error("Default value not found in option values.")
		else:
			list.selected = default_id
		
		list.item_selected.connect(
			func(id: int) -> void:
				var value : Variant = id_values[id]
				setting.set_value(value)
				value_changed.emit(value)
		)
		
		_setup_node(list)
	
	elif setting is RangeSetting:
		var slider := HSlider.new()
		
		slider.step = range_step
		
		var if_logarithmic := func(f: Callable) -> Callable:
			if logarithmic_range: return f
			else: return func(x: Variant): return x
		
		var to_linear: Callable = if_logarithmic.call(log)
		var from_linear: Callable = if_logarithmic.call(exp) 

		slider.value = to_linear.call(setting.get_value())
		slider.min_value = to_linear.call(setting.minimum)
		slider.max_value = to_linear.call(setting.maximum)
		
		var set_setting := \
			func(changed: bool) -> void: 
				if changed:
					setting.set_value(from_linear.call(slider.value))
		
		slider.value_changed.connect(func(x): value_changed.emit(from_linear.call(x)))
		
		if setting.apply_every_step:
			slider.value_changed.connect(set_setting)
		else:
			slider.drag_ended.connect(set_setting)
		
		_setup_node(slider)
	
	elif setting.default_value is bool:
		var toggle := CheckButton.new()
		
		toggle.button_pressed = setting.get_value()
		
		toggle.toggled.connect(
			func(on: bool) -> void:
				setting.set_value(on)
				value_changed.emit(on)
		)
		
		_setup_node(toggle)
	
	elif setting.default_value is String:
		var line := LineEdit.new()
		
		line.text = setting.get_value()
		
		line.text_changed.connect(
			func(text: String) -> void:
				setting.set_value(text)
				value_changed.emit(text)
		)
		
		_setup_node(line)
	
	elif setting.default_value is int:
		var line = LineEdit.new()
		
		line.text = "%d" % setting.default_value
		
		line.text_changed.connect(
			func(text: String) -> void:
				setting.set_value(int(text))
				value_changed.emit(int(text))
		)
		
		_setup_node(line)
	
	elif setting.default_value is float:
		var line = LineEdit.new()
		
		line.text = "%d" % setting.default_value
		
		line.text_changed.connect(
			func(text: String) -> void:
				setting.set_value(float(text))
				value_changed.emit(float(text))
		)
		
		_setup_node(line)
	
	elif setting.default_value is Color:
		var picker := ColorPickerButton.new()
		
		picker.color = setting.get_value()
		
		picker.color_changed.connect(
			func(color: Color) -> void:
				setting.set_value(color)
				value_changed.emit(color)
		)
		
		_setup_node(picker)
	
	else:
		push_error(
			"Setting is not of type that can be used",
			self,
			setting.key_name,
			setting.default_value
		)

func _setup_node(option_node: Control) -> void:
	var box := HBoxContainer.new()
	box.set_anchors_preset(PRESET_FULL_RECT)
	box.tooltip_text = setting.description
	node = box
	
	var label := Label.new()
	label.text = setting.display_name
	
	box.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	option_node.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	option_node.tooltip_text = setting.description
	
	add_child(box)
	box.add_child(label)
	
	if value_display != "":
		var display_node := Label.new()
		box.add_child(display_node)
		
		var set_text := func(value: Variant):
			display_node.text = value_display % value
		
		set_text.call(setting.get_value())
		
		value_changed.connect(set_text)
	
	box.add_child(option_node)
