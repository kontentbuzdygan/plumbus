extends StaticBody2D

@export var item: Item

func interact(player: Player) -> void:
    player.inventory.pick_up(item)
