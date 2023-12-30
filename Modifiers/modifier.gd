class_name Modifier
extends RefCounted

#region Signals
signal modifier_updated
#endregion

#region Properties
var _modifier_name: String
var modifier_name: String:
	get:
		return _modifier_name

var _mult: float = 1.0
var mult: float:
	get:
		return _mult

var _value: float = 0.0
var value: float:
	get: 
		return _value * _mult
#endregion

#region Builtin Functions
func _init(mod_name):
	_modifier_name = mod_name
#endregion

#region Public Functions
func add_mult(new_mult: float):
	_mult += new_mult
	modifier_updated.emit()

func increase(amount: float):
	_value += amount
	modifier_updated.emit()

func decrease(amount: float):
	_value += amount
	modifier_updated.emit()
#endregion
