extends Area2D

var _current_interactable: Interactable


func _process(_delta: float) -> void:
    var new_interactable := _closest_interactable()

    if new_interactable != _current_interactable:
        if _current_interactable:
            _current_interactable.exit_interaction(owner)
        if new_interactable:
            new_interactable.enter_interaction(owner)

    _current_interactable = new_interactable


func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("interact") and _current_interactable:
        _current_interactable.interact(owner)


func _closest_interactable() -> Interactable:
    var closest_distance := INF
    var closest_body: Interactable

    for body in get_overlapping_areas():
        if body is not Interactable:
            continue

        var distance := global_position.distance_squared_to(body.global_position)
        if distance < closest_distance:
            closest_distance = distance
            closest_body = body

    return closest_body
