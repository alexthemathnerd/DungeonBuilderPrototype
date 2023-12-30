class_name Player
extends CharacterBody2D

@export var speed: float = 150.0

@onready var animation: AnimatedSprite2D = $Animation

var last_direction: int = -1 #1 for right, -1 for left

func move() -> bool:
	var _direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	velocity = _direction * speed
	if velocity.x != 0:
		update_direction(sign(velocity.x))
	animation.flip_h = last_direction == -1
	move_and_slide()
	return velocity != Vector2.ZERO

func update_direction(new_direction: int):
	last_direction = new_direction
