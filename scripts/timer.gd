extends Timer

func _ready() -> void:
    Eventbus.start_timer.connect(_start_timer)


func _process(delta: float) -> void:
    Eventbus.timer_tick.emit(time_left)


func _on_timeout() -> void:
    Globals.is_game_running = false
    Globals.round += 1
    Eventbus.game_end.emit()


func _start_timer() -> void:
    start(wait_time)
