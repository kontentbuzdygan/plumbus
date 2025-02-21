extends VBoxContainer

var _item: Item
var item: Item:
    get: return _item
    set(value):
        _item = value
        %TextureRect.texture = item.icon


func set_highlighted(highlighted: bool) -> void:
    if highlighted:
        $Highlight.remove_theme_stylebox_override("panel")
    else:
        $Highlight.add_theme_stylebox_override("panel", StyleBoxEmpty.new())
