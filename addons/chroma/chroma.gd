@tool
extends EditorPlugin

const autoload_name: String = "ChromaOverlay"

var index: int = 0

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

var chroma_option: OptionButton

func _on_mode_selected(idx: int) -> void:
	index = idx
	update_overlays()

func add_editor_button() -> void:
	set_force_draw_over_forwarding_enabled()
	
	chroma_option = preload("res://addons/chroma/editor/ChromaOption.tscn").instantiate()
	chroma_option.item_selected.connect(_on_mode_selected)
	
	for n: String in names:
		chroma_option.add_item(n)
		
	chroma_option.select(0)
	
	add_control_to_container(EditorPlugin.CONTAINER_TOOLBAR, chroma_option)

func remove_editor_button() -> void:
	remove_control_from_container(EditorPlugin.CONTAINER_TOOLBAR, chroma_option)
	chroma_option.queue_free()
	# No way to disable force draw?

func add_autoload() -> void:
	if not ProjectSettings.has_setting("autoload/ChromaOverlay"):
		add_autoload_singleton(autoload_name, "res://addons/chroma/game/chroma_overlay.tscn")
	
func remove_autoload() -> void:
	remove_autoload_singleton(autoload_name)

func _enter_tree() -> void:
	add_autoload()
	add_editor_button()

func _exit_tree() -> void:
	remove_editor_button()
	remove_autoload()
	
func _forward_3d_force_draw_over_viewport(overlay: Control):
	overlay.material = shaders[index]
	overlay.draw_rect(overlay.get_rect(), Color.WHITE)

func _forward_canvas_force_draw_over_viewport(overlay: Control) -> void:
	overlay.material = shaders[index]
	overlay.draw_rect(overlay.get_rect(), Color.WHITE)
