extends Node
class_name Order

var item: Item
var timer: Timer

func _init(_item: Item) -> void:
    self.item = _item
    self.timer = Timer.new()
    self.timer.wait_time = 30
    self.timer.one_shot = true
    self.timer.autostart = true
    self.timer.connect("timeout", _timer_timeout)
    add_child(timer)


func _timer_timeout() -> void:
    Globals.satisfaction -= 20
    Eventbus.timeout_order.emit(self)
