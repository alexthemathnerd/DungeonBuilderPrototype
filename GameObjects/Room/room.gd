class_name Room
extends Node2D

signal door_entered(directon: Direction)

enum Direction { NORTH, EAST, SOUTH, WEST }

@export var data: RoomData

var connected_rooms: Dictionary = { NORTH = null, EAST = null, SOUTH = null, WEST = null }

@onready var _sprite := $Sprite
@onready var _north_door := $NorthDoor/Hitbox
@onready var _east_door := $EastDoor/Hitbox
@onready var _south_door := $SouthDoor/Hitbox
@onready var _west_door := $WestDoor/Hitbox

func _ready():
	assert(data != null, "A room requires a RoomData resource.")
	_sprite.texture = data.sprite
	_north_door.disabled = not data.has_north
	_east_door.disabled = not data.has_east
	_south_door.disabled = not data.has_south
	_west_door.disabled = not data.has_west

static func flip_direction(direction: Direction) -> Direction:
	var new_direction = null
	match direction: 
		Direction.NORTH:
			new_direction = Direction.SOUTH
		Direction.EAST:
			new_direction = Direction.WEST
		Direction.SOUTH:
			new_direction = Direction.NORTH
		Direction.WEST:
			new_direction = Direction.EAST 
	return new_direction

func _on_north_entered(player: Node2D):
	door_entered.emit(Direction.NORTH)

func _on_east_entered(player: Node2D):
	door_entered.emit(Direction.EAST)

func _on_south_entered(player: Node2D):
	door_entered.emit(Direction.SOUTH)

func _on_west_entered(player: Node2D):
	door_entered.emit(Direction.WEST)
