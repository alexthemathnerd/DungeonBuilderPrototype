class_name Room
extends Node2D

signal door_entered(door: Door)

@export var data: RoomData

@onready var _sprite := $Sprite

func _ready():
	assert(data != null, "A room requires a RoomData resource.")
	_sprite.texture = data.sprite
	for door: Door in get_tree().get_nodes_in_group("doors"):
		door.body_entered.connect(func(_player: Player): door_entered.emit(door))
