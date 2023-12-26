extends State
class_name PlayerMove

@export var player: CharacterBody2D
@export var move_speed := 300.0
var _move_dir : Vector2


func Enter():
	pass

func state_process(delta: float):
	_move_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()


func state_physics_process(delta: float):
	player.velocity =  _move_dir * move_speed
	player.move_and_slide()
	
	if player.velocity == Vector2.ZERO:
		Transitioned.emit(self, "Idle")
