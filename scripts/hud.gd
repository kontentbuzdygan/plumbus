extends CanvasLayer

@onready var countdown_label: Label = $CountdownLabel
@onready var round_label: Label = $RoundLabel
@onready var orders: HBoxContainer = $Orders
@onready var gold_label: Label = $GoldLabel
@onready var satisfaction_progress: ProgressBar = $SatisfactionProgress

var order_icon = preload("res://scenes/UI/order_control.tscn")

func _ready() -> void:
    Eventbus.timer_tick.connect(_update_time)
    Eventbus.game_end.connect(_game_end)
    Eventbus.new_order.connect(_new_order)
    Eventbus.finish_order.connect(_finish_order)
    satisfaction_progress.value = Globals.satisfaction


func _update_time(time_left: float) -> void:
    countdown_label.text = str(_format_time(snapped(time_left, 1))) if time_left > 0 else ""
    

func _format_time(seconds: int) -> String:
    var fminutes = str(floor(seconds / 60))
    var fseconds = str(seconds % 60)
    fseconds = "0" + fseconds if fseconds.length() == 1 else fseconds
    return "%s:%s" % [fminutes, fseconds]


func _game_end() -> void:
    round_label.text = "Round: %s" % str(Globals.round)
    for child in orders.get_children():
        child.queue_free()
    
    
func _redraw_orders(_orders: Array[Order]) -> void:
    for child in orders.get_children():
        child.queue_free()
    
    for order in _orders:
        var instance = order_icon.instantiate()
        orders.add_child(instance)
        instance.texture_rect.texture = order.item.icon
        instance.progress_bar.timer = order.timer
    

func _new_order(_orders: Array[Order]) -> void:
    _redraw_orders(_orders)
    

func _finish_order(_orders: Array[Order]) -> void:
    gold_label.text = "Gold: %s" % str(Globals.gold)
    satisfaction_progress.value = Globals.satisfaction
    _redraw_orders(_orders)
