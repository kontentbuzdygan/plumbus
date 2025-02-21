extends Node2D
class_name Inventory

var items: Array[Item]

@onready var _carried_item_icon: Sprite2D = $CarriedItemIcon


func add(item: Item) -> void:
    items.append(item)
    _update_icon()


func remove(item: Item) -> void:
    items.erase(item)
    _update_icon()


func is_full() -> bool:
    return items.size() >= 1


func get_item() -> Item:
    return items[0] if not items.is_empty() else null


func _update_icon() -> void:
    if items.is_empty():
        _carried_item_icon.texture = null
    else:
        _carried_item_icon.texture = items[0].icon
