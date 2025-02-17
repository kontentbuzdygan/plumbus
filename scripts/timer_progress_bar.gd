extends ProgressBar

@export var timer: Timer


func _process(_delta: float) -> void:
    visible = not timer.is_stopped()
    max_value = timer.wait_time
    value = timer.wait_time - timer.time_left
