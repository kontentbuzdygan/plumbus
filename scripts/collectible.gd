extends Interactable
class_name Collectible

@export var item: Item


func _is_interactable(player: Player) -> bool:
    return not player.inventory.is_full() or player.inventory._carried_item == item


func _interact(player: Player) -> void:
    if _is_interactable(player):
        player.inventory.swap(item)
