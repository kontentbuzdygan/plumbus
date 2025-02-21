extends Interactable
class_name CraftingStation

@export var recipes: Array[Recipe]

@onready var _timer: Timer = $Timer
@onready var _ui: InventoryUi = $InventoryUi

var _items: Array[Item] = []
var _active_recipe: Recipe
var _is_finished: bool = false


func _is_interactable(player: Player) -> bool:
    return not player.inventory.items.is_empty() or not _items.is_empty()


func _interact(player: Player) -> void:
    if _ui.visible:
        _ui.visible = false
    else:
        _ui.inventory = player.inventory
        _ui.set_items(player.inventory.items, _items)
        _ui.visible = true


func _on_item_taken(item: Item) -> void:
    _items.erase(item)


func _on_item_placed(item: Item) -> void:
    _items.append(item)


func _on_timer_timeout() -> void:
    if _active_recipe:
        _active_recipe = null
        _is_finished = true
