extends Area2D
class_name Interactable

@onready var _prompt: Label = $InteractionPrompt


func _ready() -> void:
    Eventbus.game_end.connect(_game_end)
    _prompt.visible = false


func enter_interaction(player: Player) -> void:
    _prompt.visible = _is_interactable(player)
    _prompt.text = _prompt_text(player)


func exit_interaction(_player: Player) -> void:
    _prompt.visible = false


func interact(player: Player) -> void:
    if _is_interactable(player):
        _interact(player)

    _prompt.visible = _is_interactable(player)
    _prompt.text = _prompt_text(player)


func _is_interactable(_player: Player) -> bool:
    return true


func _interact(_player: Player) -> void:
    pass


func _prompt_text(_player: Player) -> String:
    return "[E] interact"


func _show_prompt() -> void:
    _prompt.visible = true
    
func _game_end() -> void:
    pass
