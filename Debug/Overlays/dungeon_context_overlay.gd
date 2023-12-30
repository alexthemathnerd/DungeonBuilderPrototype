class_name DungeonContextOverlay
extends PanelContainer

@onready var _modifier_list = $ModifierSection/Vbox/ModifierList
var _modifiers = {} 
func _load_modifiers():
	_modifiers.clear()
	for child in _modifier_list.get_children():
		child.queue_free()
	for modifier: Modifier in Global.dungeon_context.modifiers:
		var label := Label.new()
		label.text = "{0}: {1}".format([modifier.modifier_name, modifier.value])
		_modifiers[modifier.modifier_name] = label
		_modifier_list.add_child(label)

func _update_modifier(modifier: Modifier):
	if not visible:
		return
	var label: Label = _modifiers[modifier.modifier_name]
	label.text = "{0}: {1}".format([modifier.modifier_name, modifier.value])


func _on_show():
	if visible:
		Global.dungeon_context.modifier_updated.connect(_update_modifier)
		_load_modifiers()
