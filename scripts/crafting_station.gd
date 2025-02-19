extends Interactable
class_name CraftingStation

@export var recipes: Array[Recipe]

@onready var _timer: Timer = $Timer
@onready var _item_icons_container: Control = $ItemIconsContainer

var _items: Array[Item] = []
var _active_recipe: Recipe
var _finished: bool = false


func _is_interactable(player: Player) -> bool:
    return _is_accepting_items() and player.inventory.get_item() != null \
        or _is_providing_items() and not player.inventory.is_full()


func _interact(player: Player) -> void:
    if _is_providing_items():
        player.inventory.add(_items[0])
        _clear_items()
        _finished = false
        $InteractionPrompt.text = "[E] place"
        return

    var item := player.inventory.remove()
    _add_item(item)

    for recipe in recipes:
        if recipe.matches(_items):
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
    icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
    _item_icons_container.add_child(icon)


func _clear_items() -> void:
    _items.clear()

    for icon in _item_icons_container.get_children():
        icon.queue_free()


func _is_accepting_items() -> bool:
    return _active_recipe == null and not _finished


func _is_providing_items() -> bool:
    return _active_recipe == null and _finished and not _items.is_empty()
