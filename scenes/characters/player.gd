class_name Player
extends CharacterBody2D

const DURATION_TACKLE := 200

enum ControlScheme {CPU, P1, P2}
enum State {MOVING, TACKLING}

@export var control_scheme : ControlScheme
@export var speed : float

@onready var animation_player : AnimationPlayer = %AnimationPlayer
@onready var player_sprite : Sprite2D = %PlayerSprite

var heading:= Vector2.RIGHT
var state := State.MOVING
var time_start_tackle := Time.get_ticks_msec()

func _process(_delta: float) -> void:
	if control_scheme == ControlScheme.CPU:
		pass #process AI movement
	else:
		if state == State.MOVING:
			handle_human_movement()
			if velocity.x != 0 and KeyTools.is_action_just_pressed(control_scheme, KeyTools.Action.SHOOT):
				state = State.TACKLING
				time_start_tackle= Time.get_ticks_msec()
			set_movement_animation()
		elif  state == State.TACKLING:
			animation_player.play("tackle")
			if Time.get_ticks_msec() - time_start_tackle > DURATION_TACKLE:
				state = State.MOVING
			
		
	
	
	set_heading()
	move_and_slide()
	flip_sprites()

func set_movement_animation() -> void:
	if velocity.length() > 0:
		animation_player.play("run")
	else:
		animation_player.play("idle")

func handle_human_movement() -> void:
	var direction := KeyTools.get_input_vector(control_scheme)
	velocity= direction * speed

func set_heading() -> void:
	if velocity.x > 0:
		heading = Vector2.RIGHT
	elif velocity.x < 0:
		heading = Vector2.LEFT
		
func flip_sprites() -> void:
	if heading == Vector2.RIGHT:
		player_sprite.flip_h= false
	elif heading == Vector2.LEFT:
		player_sprite.flip_h = true
	
