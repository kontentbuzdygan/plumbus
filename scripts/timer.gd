extends Timer

func _process(delta: float) -> void:
	Eventbus.timer_tick.emit(time_left)


func _on_timeout() -> void:
	print("Game over")
