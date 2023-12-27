class_name Dungeon
extends Node2D

@export var initial_room_data: RoomData
@export var player: Player

var current_room: Room

@onready var _camera: Camera2D = $Camera
@onready var _room_template := preload("res://GameObjects/Room/room.tscn")

func _ready():
	assert(initial_room_data != null, "A dungeon requires an initial room.")
	_add_room(null, initial_room_data)

func _add_room(door: Door, room_data: RoomData) -> Room:
	var room: Room = _room_template.instantiate()
	room.data = room_data
	room.door_entered.connect(_change_room)
	if door != null:
		room.global_position = door.room_location.global_position
	add_child(room)
	return room

func _change_room(door: Door):
	var next_room = door.room
	if next_room == null:
		next_room = _add_room(door, RoomData.new())
	door.room = next_room
	player.global_position = door.teleport_location.global_position
	_camera.global_position = next_room.global_position
	
	
