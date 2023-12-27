class_name Player
extends CharacterBody2D

@export var speed: float = 150.0

@onready var animation: AnimatedSprite2D = $Animation

func move() -> bool:
	var _direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	velocity = _direction * speed
	animation.flip_h = velocity.x < 0
	move_and_slide()
	return velocity != Vector2.ZERO
