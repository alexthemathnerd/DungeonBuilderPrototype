class_name PlayerIdle
extends PlayerState

func enter(_msg := {}) -> void:
	player.velocity = Vector2.ZERO
	player.animation.play("idle")

func update(delta: float):
	if Input.get_vector("move_left", "move_right", "move_up", "move_down") != Vector2.ZERO:
		state_machine.transition_to("Move")
