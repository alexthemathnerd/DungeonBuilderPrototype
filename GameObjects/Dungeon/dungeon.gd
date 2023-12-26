class_name Dungeon
extends Node2D

@export var initial_room_data: RoomData

var current_room: Room

@onready var _camera := $Camera
@onready var _room_template := preload("res://GameObjects/Room/room.tscn")

func _ready():
	assert(initial_room_data != null, "A dungeon requires an initial room.")
	var room: Room = _room_template.instantiate()
	room.data = initial_room_data
	room.door_entered.connect(_change_room)
	add_child(room)
	current_room = room

func add_room(direction: Room.Direction, room_data: RoomData):
	var room: Room = _room_template.instantiate()
	room.data = room_data
	room.door_entered.connect(_change_room)
	room.connected_rooms[direction] = current_room
	current_room.connected_rooms[Room.flip_direction(direction)] = room
	match direction:
		Room.Direction.NORTH:
			room.position.y -= 512
		Room.Direction.EAST:
			room.position.x += 512
		Room.Direction.SOUTH:
			room.position.y += 512
		Room.Direction.WEST:
			room.position.x -= 512
	add_child(room)
	return room

func _change_room(direction: Room.Direction):
	var next_room = current_room.connected_rooms[direction]
	if next_room == null:
		# TODO: Make user chose room data
		next_room = add_room(direction, RoomData.new())
	current_room = next_room
	_camera.position = current_room.position
