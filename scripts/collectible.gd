extends Interactable
class_name Collectible

@export var item: Item


func _is_interactable(player: Player) -> bool:
    return Globals.is_game_running and not player.inventory.is_full() or player.inventory.get_item() == item


func _interact(player: Player) -> void:
    if player.inventory.get_item() == item:
        player.inventory.remove()
    else:
        player.inventory.add(item)


func _prompt_text(player: Player) -> String:
    if player.inventory.get_item() == item:
        return "[E] put back"
    else:
        return "[E] pick up"
