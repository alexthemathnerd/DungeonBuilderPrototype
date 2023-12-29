class_name DungeonContext
extends RefCounted

signal modifier_updated(modifier: Modifier)

var modifiers: Array[Modifier] = []

func _init():
	_add_modifier("Enemy_MaxHealth")
	_add_modifier("Enemy_Damage")
	_add_modifier("Player_MaxHealth")
	_add_modifier("Player_Damage")

func _add_modifier(modifier_name: String):
	var modifier := Modifier.new(modifier_name)
	modifier.modifier_updated.connect(func(): modifier_updated.emit(modifier))
	modifiers.append(modifier)
	
func get_modifier(modifier_name: String) -> Modifier:
	return modifiers.filter(func(mod: Modifier): return mod.modifier_name == modifier_name).front()
