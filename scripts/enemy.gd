extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: Player = $"../Player"

const SPEED = 80

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dest = (player.position - position).normalized()
	velocity = dest * SPEED
	move_and_slide()
	update_animation(dest)


func update_animation(vec: Vector2) -> void:
	if abs(vec.x) > abs(vec.y):
		animated_sprite_2d.play("right_walk") if vec.x > 0 else animated_sprite_2d.play("left_walk")
	else:
		animated_sprite_2d.play("down_walk") if vec.y > 0 else animated_sprite_2d.play("up_walk")
