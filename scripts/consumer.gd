extends Interactable
class_name Consumer


func _is_interactable(player: Player) -> bool:
    return player.inventory.has_item()


func _interact(player: Player) -> void:
    var item := player.inventory.remove()
    print("placed ", item.name)
