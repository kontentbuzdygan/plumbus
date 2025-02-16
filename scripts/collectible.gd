extends StaticBody2D

@export var item: Item

@onready var _prompt: Label = $InteractionPrompt

func _ready() -> void:
	_prompt.visible = false


func enter_interaction(player: Player) -> void:
	update_prompt(player)


func exit_interaction(_player: Player) -> void:
	_prompt.visible = false


func interact(player: Player) -> void:
	player.inventory.pick_up(item)
	update_prompt(player)


func update_prompt(player: Player) -> void:
	_prompt.visible = not player.inventory.is_full()
