class_name Enemy
extends CharacterBody2D

var target: Node2D = null

#@export var initial_data: EnemyData

@onready var _speed: float
var _org_speed: float

@onready var _health: float
@onready var _animation_sprite: AnimatedSprite2D = $EnemyAnimation

@onready var _hitbox: CollisionShape2D = $HitboxComponent

@onready var _state_machine: StateMachine = $StateMachine

func _ready():
	pass

func _move():
	print("test")
	if target != null:
		velocity = (target.position - position).normalized() * _speed
		_animation_sprite.flip_h = velocity.x < 0
		move_and_slide()

func _die():
	_hitbox.disabled = true
	_animation_sprite.play("Die")
	await _animation_sprite.animation_finished
	queue_free()
