extends Interactable
class_name Consumer


func _is_interactable(player: Player) -> bool:
    return player.inventory.get_item() != null


func _interact(player: Player) -> void:
    var item := player.inventory.remove_first()
    print("placed ", item.name)


func _prompt_text(_player: Player) -> String:
    return "[E] place"
