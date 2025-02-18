@tool
extends EditorPlugin

var inspector_button_plugin


func _enter_tree() -> void:
    inspector_button_plugin = preload("res://addons/inspector_button/inspector_button.gd").new()
    add_inspector_plugin(inspector_button_plugin)


func _exit_tree() -> void:
    remove_inspector_plugin(inspector_button_plugin)
