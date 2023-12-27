class_name PlayerMove
extends PlayerState

func enter(_msg := {}):
	player.animation.play("move")

func update_physics(_delta: float):
	if not player.move():
		state_machine.transition_to("Idle")

func exit():
	player.animation.stop()
