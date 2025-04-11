extends Node
class_name esc_game

func _process(_delta: float) -> void:
	if Input.is_action_pressed("esc"):
		get_tree().quit()
