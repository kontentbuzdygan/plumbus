extends Interactable
class_name Collectible

@export var item: Item


func _is_interactable(player: Player) -> bool:
    return not player.inventory.has_item()


func _interact(player: Player) -> void:
    player.inventory.add(item)
