extends ColorRect

var fade_tween: Tween

var index: int = 0

@onready var mode_panel: PanelContainer = $ModePanel
@onready var mode_label: Label = $ModePanel/MarginContainer/ModeLabel

func _init() -> void:
	# From: https://github.com/godot-extended-libraries/godot-debug-menu/blob/master/addons/debug_menu/debug_menu.gd#L81
	if not InputMap.has_action("cycle_chroma"):
		InputMap.add_action("cycle_chroma")
		var event: InputEventKey = InputEventKey.new()
		event.keycode = KEY_F4
		InputMap.action_add_event("cycle_chroma", event)
		
var shaders: Array = [
	preload("res://addons/chroma/res/materials/chroma_default.tres"),
	preload("res://addons/chroma/res/materials/chroma_greyscale.tres"),
	preload("res://addons/chroma/res/materials/chroma_protanopia.tres"),
	preload("res://addons/chroma/res/materials/chroma_deutaranopia.tres"),
	preload("res://addons/chroma/res/materials/chroma_tritanopia.tres")
]

var names: Array[String] = [
	"Default",
	"Greyscale",
	"Protanopia",
	"Deuteranopia",
	"Tritanopia"
]

func _ready() -> void:
	material = shaders.front()
	mode_label.text = names.front()
	
	mode_panel.modulate = Color.TRANSPARENT

func update_mode() -> void:
	index += 1
	index = index % shaders.size()
	
	# use tween to show new mode
	material = shaders[index]
	mode_label.text = names[index]
	
	if fade_tween != null:
		fade_tween.kill()
		
	fade_tween = create_tween()
		
	fade_tween.tween_property(mode_panel, "modulate", Color.WHITE, 0.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CIRC)
	fade_tween.tween_interval(0.5)
	fade_tween.tween_property(mode_panel, "modulate", Color.TRANSPARENT, 0.8).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("cycle_chroma"):
		update_mode()
