class_name Room
extends Node2D

#signal room_entered(room: Room, player: Player)
#signal room_exited(room: Room, player: Player)
signal door_entered(door: Door, player: Player)

@export var data: RoomData

@onready var _sprite := $Sprite
@onready var _doors := $Doors

func _ready():
	assert(data != null, "A room requires a RoomData resource.")
	_sprite.texture = data.sprite
	for door: Door in _doors.get_children():
		door.body_entered.connect(func(player: Player): door_entered.emit(door, player))
