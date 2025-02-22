extends Timer
class_name Orders

@export var wanted_items: Array[Item]
var active_orders: Array[Order] = []

func _ready() -> void:
    Eventbus.start_timer.connect(_game_start)
    Eventbus.game_end.connect(_game_end)
    Eventbus.timeout_order.connect(finish_order)


func _start_random_timer() -> void:
    var random_time := randf_range(1, 10)
    start(random_time)


func _game_start() -> void:
    _start_random_timer()


func _game_end() -> void:
    for active_order in active_orders:
        active_order.queue_free()
    active_orders.clear()
    stop()


func _on_timeout() -> void:
    if not Globals.is_game_running:
        return
        
    if active_orders.size() < 4:
        var item = wanted_items.pick_random()
        var order = Order.new(item)
        order.item = item
        active_orders.append(order)
        # TODO: do I seriously have to add a new Order to the scene
        # in order to start the timer?
        add_child(order)
        Eventbus.new_order.emit(active_orders)
        
    _start_random_timer()


func finish_order(order: Order):
    if order:
        order.timer.stop()
        order.queue_free() # TODO: omg
    active_orders.erase(order)
    Eventbus.finish_order.emit(active_orders)


func find_item_in_orders(item: Item) -> Order:
    for order in active_orders:
        if order.item == item:
            return order
            
    return null
