extends Timer

@onready var label: Label = $"../HBoxContainer/CountdownLabel"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = str(_format_time(snapped(time_left, 1)))


func _on_timeout() -> void:
	print("Game over")


func _format_time(seconds: int) -> String:
	var fminutes = str(floor(seconds / 60))
	var fseconds = str(seconds % 60)
	fseconds = "0" + fseconds if fseconds.length() == 1 else fseconds
	return "%s:%s" % [fminutes, fseconds]
