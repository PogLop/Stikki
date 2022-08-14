tool
extends EditorPlugin

const board = preload("board.tscn")

var b_instance = board.instance()

func _enter_tree():
	b_instance = board.instance()
	get_editor_interface().get_editor_viewport().add_child(b_instance)
	make_visible(false)
	pass

func _exit_tree():
	pass

func has_main_screen():
	return true

func make_visible(visible):
	if b_instance:
		b_instance.visible = visible

func get_plugin_name():
	return "Stikki"

func get_plugin_icon():
	return get_editor_interface().get_base_control().get_icon("Sprite", "EditorIcons")
