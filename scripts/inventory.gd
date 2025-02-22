extends Node2D
class_name Inventory

var _carried_item: Item

@onready var _carried_item_icon: Sprite2D = $CarriedItemIcon

func _ready() -> void:
    Eventbus.game_end.connect(remove)


func add(item: Item) -> void:
    _carried_item = item
    _update_icon()


func remove() -> Item:
    var item := _carried_item
    _carried_item = null
    _update_icon()
    return item


func is_full() -> bool:
    return _carried_item != null


func get_item() -> Item:
    return _carried_item


func _update_icon() -> void:
    if _carried_item:
        _carried_item_icon.texture = _carried_item.icon
    else:
        _carried_item_icon.texture = null
