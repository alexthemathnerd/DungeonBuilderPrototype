class_name Game
extends Control
## 
##

#region Signals
signal menu_loaded
signal menu_unloaded

signal overlay_loaded
signal overlay_unloaded

signal scene_loaded
signal scene_unloaded
#endregion

#region Fields
@export var initial_menu: String
@export var initial_overlay: String
@export var initial_scene: String

var _loaded_menu: Control
var _loaded_overlay: Control
var _loaded_scene: Node2D

@onready var _menu := $Menu
@onready var _overlay := $Overlay
@onready var _scene := $Scene
#endregion

#region Builtins Methods
func _ready():
	Global.game = self as Game
	load_menu(initial_menu)
	load_overlay(initial_overlay)
	load_scene(initial_scene)
#endregion

#region Menu Methods
func unload_menu():
	if is_instance_valid(_loaded_menu):
		_loaded_menu.queue_free()
		menu_unloaded.emit()
	_loaded_menu = null

func load_menu(menu_name: String) -> bool:
	if menu_name == null:
		return false
	unload_menu()
	var menu_path := "res://Menus/%s.tscn" % menu_name
	var menu_resource: PackedScene = load(menu_path)
	if menu_resource:
		_loaded_menu = menu_resource.instantiate()
		_menu.add_child(_loaded_menu)
		menu_loaded.emit()
	return menu_resource != null
#endregion

#region Overlay Methods
func unload_overlay():
	if is_instance_valid(_loaded_overlay):
		_loaded_overlay.queue_free()
		overlay_unloaded.emit()
	_loaded_overlay = null

func load_overlay(overlay_name: String) -> bool:
	if overlay_name == null:
		return false
	unload_overlay()
	var overlay_path := "res://Overlays/%s.tscn" % overlay_name
	var overlay_resource: PackedScene = load(overlay_path)
	if overlay_resource:
		_loaded_overlay = overlay_resource.instantiate()
		_overlay.add_child(_loaded_overlay)

	return overlay_resource != null
#endregion

#region Scene Methods
func unload_scene():
	if is_instance_valid(_loaded_scene):
		_loaded_scene.queue_free()
		scene_unloaded.emit()
	_loaded_scene = null

func load_scene(scene_name: String) -> bool:
	if scene_name == null:
		return false
	unload_scene()
	var scene_path := "res://Scenes/%s.tscn" % scene_name
	var scene_resource: PackedScene = load(scene_path)
	if scene_resource:
		_loaded_scene = scene_resource.instantiate()
		_scene.add_child(_loaded_scene)
		scene_loaded.emit()
	return scene_resource != null
#endregion
