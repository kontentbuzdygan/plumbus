extends CharacterBody2D
class_name Player

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var inventory: Inventory = $Inventory

const SPEED = 150.0

var direction_names = {
    Vector2.LEFT: "left",
    Vector2.RIGHT: "right",
    Vector2.UP: "up",
    Vector2.DOWN: "down"
}

var last_direction := Vector2.DOWN


func _process(_delta: float) -> void:
    var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
    velocity = direction * SPEED

    move_and_slide()
    update_animation(direction)


func update_animation(direction: Vector2) -> void:
    match direction:
        Vector2.ZERO:
            animated_sprite_2d.play(direction_names.get(last_direction) + "_idle")
            return
        Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN:
            last_direction = direction

    animated_sprite_2d.play(direction_names.get(last_direction) + "_walk")
