extends Interactable
class_name CraftingStation

@export var recipes: Array[Recipe]

@onready var _timer: Timer = $Timer
@onready var _inventory: Inventory = $Inventory
@onready var _ui: NewInventory = $NewInventory

var _active_recipe: Recipe
var _is_finished: bool = false


func _is_interactable(player: Player) -> bool:
    return not player.inventory.is_empty() or not _inventory.is_empty()


func _interact(player: Player) -> void:
    if _ui.visible:
        player.set_process(true)
        _ui.hide()

        for recipe in recipes:
            if recipe.matches(_inventory.items):
                _inventory.clear()
                _active_recipe = recipe
                _timer.start(recipe.time_seconds)
                break
    else:
        player.set_process(false)
        _ui.top_inventory = player.inventory
        _ui.open()


func _on_timer_timeout() -> void:
    if _active_recipe:
        _inventory.add(_active_recipe.result)
        _active_recipe = null
        _is_finished = true
