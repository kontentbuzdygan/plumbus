extends Node2D
class_name Inventory

var _carried_item: Item

@onready var carried_item_icon: Sprite2D = $CarriedItemIcon

func add(item: Item) -> void:
    if has_item():
        return

    _carried_item = item
    _update_icon()


func remove() -> Item:
    var item := _carried_item
    _carried_item = null
    _update_icon()
    return item


func has_item() -> bool:
    return _carried_item != null


func _update_icon() -> void:
    if _carried_item:
        carried_item_icon.texture = _carried_item.icon
    else:
        carried_item_icon.texture = null
