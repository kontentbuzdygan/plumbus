extends CanvasLayer

@onready var countdown_label: Label = $CountdownLabel
@onready var round_label: Label = $RoundLabel

func _ready() -> void:
    Eventbus.timer_tick.connect(_update_time)
    Eventbus.game_end.connect(_game_end)
    

func _update_time(time_left: float) -> void:
    countdown_label.text = str(_format_time(snapped(time_left, 1))) if time_left > 0 else ""
    

func _format_time(seconds: int) -> String:
    var fminutes = str(floor(seconds / 60))
    var fseconds = str(seconds % 60)
    fseconds = "0" + fseconds if fseconds.length() == 1 else fseconds
    return "%s:%s" % [fminutes, fseconds]


func _game_end() -> void:
    round_label.text = "Round: %s" % str(Globals.round)
