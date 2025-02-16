extends Node2D
class_name Inventory

var _carried_item: Item

@onready var carried_item_icon: Sprite2D = $CarriedItemIcon

func pick_up(item: Item) -> void:
    if is_full():
        return

    _carried_item = item
    carried_item_icon.texture = item.icon


func is_full() -> bool:
    return _carried_item != null
