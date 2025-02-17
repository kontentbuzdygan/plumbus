extends Interactable
class_name CraftingStation

@export var recipes: Array[Recipe]

@onready var _timer: Timer = $Timer
@onready var _item_icons_container: Control = $ItemIconsContainer

var _items: Array[Item] = []
var _active_recipe: Recipe
var _finished: bool = false


func _is_interactable(player: Player) -> bool:
    return _active_recipe == null and player.inventory.get_item() != null \
        or _finished and not player.inventory.is_full()


func _interact(player: Player) -> void:
    if _finished:
        player.inventory.add(_items[0])
        _clear_items()
        _finished = false
        $InteractionPrompt.text = "[E] place"
        return

    var item := player.inventory.remove()
    _add_item(item)

    for recipe in recipes:
        if recipe.is_satisfied(_items):
            _active_recipe = recipe
            _timer.start(recipe.time_seconds)


func _on_timer_timeout() -> void:
    if _active_recipe:
        _clear_items()
        _add_item(_active_recipe.result)
        _active_recipe = null
        _finished = true
        $InteractionPrompt.text = "[E] take"


func _add_item(item: Item) -> void:
    _items.append(item)

    var icon := TextureRect.new()
    icon.texture = item.icon
    _item_icons_container.add_child(icon)


func _clear_items() -> void:
    _items.clear()

    for icon in _item_icons_container.get_children():
        icon.queue_free()
