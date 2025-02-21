extends HBoxContainer
class_name InventoryUi

@export var column: PackedScene

var _selected: int
var selected: int:
    get: return _selected
    set(value):
        get_child(_selected).set_highlighted(false)
        _selected = value
        get_child(_selected).set_highlighted(true)

var inventory: Inventory

signal item_taken(item: Item)
signal item_placed(item: Item)


func _unhandled_input(event: InputEvent) -> void:
    if not visible:
        return

    if event.is_action_pressed("move_left"):
        selected = (selected - 1) % get_child_count()
        get_viewport().set_input_as_handled()

    if event.is_action_pressed("move_right"):
        selected = (selected + 1) % get_child_count()
        get_viewport().set_input_as_handled()

    var active_column = get_child(selected)

    if event.is_action_pressed("move_up") and active_column.alignment == ALIGNMENT_END and not inventory.is_full():
        active_column.alignment = ALIGNMENT_BEGIN
        item_taken.emit(active_column.item)
        inventory.add(active_column.item)

    if event.is_action_pressed("move_down") and active_column.alignment == ALIGNMENT_BEGIN:
        active_column.alignment = ALIGNMENT_END
        inventory.remove(active_column.item)
        item_placed.emit(active_column.item)


func set_items(items_top: Array[Item], items_bottom: Array[Item]) -> void:
    for child in get_children():
        child.free()

    for item in items_top:
        _add_column(item, ALIGNMENT_BEGIN)
    for item in items_bottom:
        _add_column(item, ALIGNMENT_END)

    selected = 0


func _add_column(item: Item, align: int) -> void:
    var column_instance = column.instantiate()
    column_instance.item = item
    column_instance.set_highlighted(false)
    column_instance.alignment = align
    add_child(column_instance)
