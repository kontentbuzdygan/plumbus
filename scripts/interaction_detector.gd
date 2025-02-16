extends Area2D

var _current_interactable: Node2D


func _process(_delta: float) -> void:
    var new_interactable := closest_interactable()

    if new_interactable != _current_interactable:
        if _current_interactable and _current_interactable.has_method("exit_interaction"):
            _current_interactable.exit_interaction(owner)
        if new_interactable and new_interactable.has_method("enter_interaction"):
            new_interactable.enter_interaction(owner)

    _current_interactable = new_interactable


func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("interact"):
        if _current_interactable and _current_interactable.has_method("interact"):
            _current_interactable.interact(owner)


func closest_interactable() -> Node2D:
    var closest_distance := INF
    var closest_body: Node2D

    for body in get_overlapping_bodies():
        var distance := global_position.distance_squared_to(body.global_position)
        if distance < closest_distance:
            closest_distance = distance
            closest_body = body

    return closest_body
