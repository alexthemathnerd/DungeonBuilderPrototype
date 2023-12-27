class_name Dungeon
extends Node2D

@export var initial_room_data: RoomData

@onready var _camera: Camera2D = $Camera
@onready var _room_template := preload("res://GameObjects/Room/room.tscn")

func _ready():
	assert(initial_room_data != null, "A dungeon requires an initial room.")
	_add_room(null, initial_room_data)

func _add_room(door: Door, room_data: RoomData) -> void:
	var room: Room = _room_template.instantiate()
	room.data = room_data
	room.door_entered.connect(_change_room)
	if door != null:
		room.global_position = door.room_location.global_position
	room.add_to_group("rooms")
	call_deferred("add_child", room)

func _change_room(door: Door, player: Player):
	player.global_position = door.teleport_location.global_position
	if not _check_for_room(door):
		_add_room(door, RoomData.new())
	_camera.global_position = door.room_location.global_position
	

func _check_for_room(door: Door) -> bool:
	for room: Room in get_tree().get_nodes_in_group("rooms"):
		if room.global_position.is_equal_approx(door.room_location.global_position):
			return true
	return false
	
