extends Area2D
class_name Interactable

@onready var _prompt: Label = $InteractionPrompt


func _ready() -> void:
    _prompt.visible = false


func enter_interaction(player: Player) -> void:
    _prompt.visible = _is_interactable(player)
    _prompt.text = _get_prompt_text(player)


func exit_interaction(_player: Player) -> void:
    _prompt.visible = false


func interact(_player: Player) -> void:
    if _is_interactable(_player):
        _interact(_player)
    _prompt.visible = _is_interactable(_player)
    _prompt.text = _get_prompt_text(_player)


func _is_interactable(_player: Player) -> bool:
    return true


func _interact(_player: Player) -> void:
    pass
    
    
func _get_prompt_text(_player: Player) -> String:
    return "[E] put down" if _player.inventory.is_full() else "[E] pick up"
