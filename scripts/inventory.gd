extends Node2D
class_name Inventory

@export var items: Array[Item]
@export var capacity: int = 1

# TODO: Display all items
@onready var _carried_item_icon: Sprite2D = $CarriedItemIcon


func add(item: Item) -> void:
    items.append(item)
    _update_icon()


func remove(item: Item) -> void:
    items.erase(item)
    _update_icon()


func remove_first() -> Item:
    var item = items.pop_front()
    _update_icon()
    return item


func clear() -> void:
    items.clear()
    _update_icon()


func is_full() -> bool:
    return items.size() >= capacity


func is_empty() -> bool:
    return items.is_empty()


func get_item() -> Item:
    return items[0] if not items.is_empty() else null


func _update_icon() -> void:
    if not _carried_item_icon:
        return

    if items.is_empty():
        _carried_item_icon.texture = null
    else:
        _carried_item_icon.texture = items[0].icon
