extends Interactable
class_name Client

@onready var orders: Orders = $"../Orders"

func _is_interactable(player: Player):
    return Globals.is_game_running and player.inventory.is_full()


func _interact(player: Player):
    var item := player.inventory.remove()
    var order = orders.find_item_in_orders(item)
    if order:
        Globals.gold += 10
        Globals.satisfaction += 10
    else:
        Globals.satisfaction -= 20
        
    orders.finish_order(order)


func _prompt_text(_player: Player) -> String:
    return "[E] feed the crab"
