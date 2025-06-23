class_name PlayerStateMoving
extends PlayerState


func _process(delta: float) -> void:
	if player.control_scheme == Player.ControlScheme.CPU:
		pass #process AI movement
	else:
		handle_human_movement()
	player.set_movement_animation()
	player.set_heading()
	
	
	
	
func handle_human_movement() -> void:
	var direction := KeyTools.get_input_vector(player.control_scheme)
	player.velocity= direction * player.speed
	
	if player.velocity != Vector2.ZERO and KeyTools.is_action_just_pressed(player.control_scheme, KeyTools.Action.SHOOT):
		state_transition_requested.emit(Player.State.TACKLING)
