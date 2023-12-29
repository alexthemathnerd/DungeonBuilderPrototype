class_name DungeonDisplay
extends Control

@onready var _modifiers = $Modifiers

func _ready():
	Global.dungeon_context.modifier_updated.connect(func(_mod): _update_display())
	_update_display()

func _update_display():
	_modifiers.clear()
	for modifier: Modifier in Global.dungeon_context.modifiers:
		_modifiers.add_item("{0}: {1}".format([modifier.modifier_name, modifier.value]))
