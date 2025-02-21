extends Interactable
class_name GameStarter

func _ready() -> void:
    Eventbus.game_end.connect(_game_end)
    _prompt.visible = true
    

func _is_interactable(player: Player) -> bool:
    return not Globals.is_game_running


func exit_interaction(_player: Player) -> void:
    _prompt.visible = _is_interactable(_player)
    

func _interact(player: Player) -> void:
    Globals.is_game_running = true
    Eventbus.start_timer.emit()


func _prompt_text(_player: Player) -> String:
    return "[E] Start game"


func _game_end() -> void:
    _prompt.visible = true
