tool
extends EditorPlugin

var button
var container = EditorPlugin.CONTAINER_CANVAS_EDITOR_MENU

func _enter_tree():
	button = preload("res://addons/create_game_button/game_button.tscn").instance()
	add_control_to_container(container,button)
	pass
	
func _exit_tree():
	remove_control_from_container(container, button)
	button.free()
	pass
