extends Interactable
class_name Consumer

@onready var _item_icons_container: HBoxContainer = $ItemIconsContainer

var _items: Array[Item] = []
var _consumer_size = 3


func _is_interactable(player: Player) -> bool:
    return player.inventory.get_item() != null and _items.size() < _consumer_size \
            or player.inventory.get_item() == null and _items.size() > 0


func _interact(player: Player) -> void:
    if player.inventory.is_full() and _items.size() < _consumer_size:
        var item := player.inventory.remove()
        _add_item(item)
        print("placed ", item.name)
    elif not player.inventory.is_full():
        player.inventory.add(_pop_item())
        
        
func _add_item(item: Item) -> void:
    _items.append(item)

    var icon := TextureRect.new()
    icon.texture = item.icon
    icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
    _item_icons_container.add_child(icon)
    

func _pop_item() -> Item:
    var last_child := _item_icons_container.get_child(_item_icons_container.get_child_count()-1)
    if last_child:
        _item_icons_container.remove_child(last_child)
    return _items.pop_back()
