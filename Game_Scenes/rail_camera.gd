extends Camera2D

@export_range(100, 10000) var cam_speed: float = 500
var left_limit: float = -300
var right_limit: float = 1600
var mouse_movement_area: float = 0.1
var shift_speed_multipler: float = 3

# happens every frame, updates position based on user input
func _process(delta: float) -> void:
	var position_delta: float = 0
	var direction: int = 0
	var shift_held: bool = Input.is_action_pressed("shift")
	
	var mouse_position: float = DisplayServer.mouse_get_position().x
	var current_screen_res: float = DisplayServer.window_get_size().x
	var is_focused: bool = get_window().has_focus()
	
	# holding left right
	if Input.is_action_pressed("left"):
		direction -= 1
	if Input.is_action_pressed("right"):
		direction += 1
	
	# mouse is far left or far right
	if is_focused:
		if mouse_position < current_screen_res * mouse_movement_area and mouse_position > 0:
			direction -= 1
		elif mouse_position > current_screen_res * (1 - mouse_movement_area) and mouse_position < current_screen_res:
			direction += 1
	
	# update position
	position_delta = direction * delta * cam_speed
	if shift_held:
		position_delta *= shift_speed_multipler
	position.x = clampf(position.x + position_delta, left_limit, right_limit)
