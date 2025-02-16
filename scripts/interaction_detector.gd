extends Area2D

func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("interact"):
        var closest_body := closest_interactable()
        if closest_body and closest_body.has_method("interact"):
            closest_body.interact(owner)


func closest_interactable() -> Node2D:
    var closest_distance := INF
    var closest_body: Node2D

    for body in get_overlapping_bodies():
        var distance := global_position.distance_squared_to(body.global_position)
        if distance < closest_distance:
            closest_distance = distance
            closest_body = body

    return closest_body
