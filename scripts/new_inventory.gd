extends ColorRect
class_name NewInventory

enum ColumnState { TOP, BOTTOM }

@export var top_inventory: Inventory
@export var bottom_inventory: Inventory
@export var icon_size: float = 16
@export var cell_margin: float = 1
@export var highlight: StyleBox

var items: Array[Item]
var states: Array[ColumnState]
var selected: int = 0
var cell_size: float:
    get: return icon_size + cell_margin * 2


func open() -> void:
    items = []
    states = []
    selected = 0

    for item in top_inventory.items:
        items.append(item)
        states.append(ColumnState.TOP)

    for item in bottom_inventory.items:
        items.append(item)
        states.append(ColumnState.BOTTOM)

    size.x = items.size() * cell_size
    size.y = 2 * cell_size

    show()


func _draw() -> void:
    for i in range(items.size()):
        var x = i * cell_size
        var y = 0.0 if states[i] == ColumnState.TOP else cell_size

        if i == selected:
            draw_style_box(highlight, Rect2(x, y, cell_size, cell_size))

        draw_texture_rect(items[i].icon, Rect2(x + cell_margin, y + cell_margin, icon_size, icon_size), false)


func _unhandled_input(event: InputEvent) -> void:
    if not visible:
        return

    if event.is_action_pressed("ui_up"):
        if states[selected] == ColumnState.BOTTOM and not top_inventory.is_full():
            bottom_inventory.remove(items[selected])
            top_inventory.add(items[selected])
            states[selected] = ColumnState.TOP

    if event.is_action_pressed("ui_down"):
        if states[selected] == ColumnState.TOP and not bottom_inventory.is_full():
            top_inventory.remove(items[selected])
            bottom_inventory.add(items[selected])
            states[selected] = ColumnState.BOTTOM

    if event.is_action_pressed("ui_left"):
        selected = max(0, selected - 1)

    if event.is_action_pressed("ui_right"):
        selected = min(items.size() - 1, selected + 1)

    queue_redraw()
