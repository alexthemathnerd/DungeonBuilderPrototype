extends State
class_name PlayerIdle

var _move_dir: Vector2

func Enter():
	pass

func state_process(delta: float):
	_move_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if _move_dir != Vector2.ZERO:
		Transitioned.emit(self, "Move")
