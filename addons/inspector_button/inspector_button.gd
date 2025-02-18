@tool
extends EditorInspectorPlugin


class ButtonProperty extends EditorProperty:
    var _control := Button.new()

    func _init(label: String) -> void:
        add_child(_control)
        add_focusable(_control)
        _control.text = label
        _control.pressed.connect(_on_button_pressed)

    func _on_button_pressed() -> void:
        get_edited_object().call("_inspector_button_pressed")


func _can_handle(object):
    return object.has_method("_inspector_button_pressed")


func _parse_end(object: Object) -> void:
    var constants: Dictionary = object.get_script().get_script_constant_map()
    var label = constants.get("INSPECTOR_BUTTON_LABEL", "Run")

    add_property_editor("run", ButtonProperty.new(label))
