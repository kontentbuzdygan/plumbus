extends Area2D


func _on_body_entered(body: Node2D) -> void:
	print("You died!")
	call_deferred("kill_player")
	

func kill_player():
	get_tree().reload_current_scene()
