class_name DebugTerminal
extends Control

#region Enums
enum PrintType { Default, Hint, Warning, Error, Success }
#endregion

#region Public 
var commands := [
	HelpCommand.new(),
	DebugShowCommand.new(),
	DebugHideCommand.new(),
]
#endregion

#region Private Fields
var _command_history: Array[String] = []
var _history_indx: int = -1
#endregion

#region Scene Elements
@onready var _command_input = $Margin/Panel/Padding/VBoxContainer/Footer/CommandInput
@onready var _history_scroll_container = $Margin/Panel/Padding/VBoxContainer/HistoryScrollContainer
@onready var _history_content = $Margin/Panel/Padding/VBoxContainer/HistoryScrollContainer/HistoryContent
#endregion

#region Preloads
@onready var _debug_theme := preload("res://Debug/debug_theme.tres")
#endregion

#region Builtin Functions
func _ready():
	_command_input.grab_focus()
	_history_scroll_container.get_v_scroll_bar().value = _history_scroll_container.get_v_scroll_bar().max_value

func _input(event):
	if event.is_action_pressed("close_terminal") and visible:
		disable_terminal()
	if event.is_action_pressed("open_terminal") and not visible:
		enable_terminal()
	if event.is_action_pressed("terminal_up") and _command_input.has_focus() and not _command_history.is_empty():
		if _history_indx == -1:
			return
		_history_indx -= 1
		_command_input.text = _command_history[_history_indx]
	
	if event.is_action_pressed("terminal_down") and _command_input.has_focus() and not _command_history.is_empty():
		if _history_indx == _command_history.size():
			return
		_history_indx += 1
		_command_input.text = _command_history[_history_indx]

#endregion

#region Public Functions
func get_command(command_name: String) -> Command:
	return commands.filter(func(command: Command): return command.name == command_name).front()

func terminal_print(text: String, type := PrintType.Default):
	var text_label = Label.new()
	text_label.text = text 
	text_label.theme = _debug_theme
	text_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	text_label.size_flags_horizontal = SIZE_EXPAND_FILL
	var label_color
	match type:
		PrintType.Default:
			label_color = Color("#efefef")
		PrintType.Hint:
			label_color = Color("#666666")
		PrintType.Warning:
			label_color = Color("#f39f24")
		PrintType.Error:
			label_color = Color("#f91545")
		PrintType.Success:
			label_color = Color("#00ff66")
	text_label.modulate = label_color
	_history_content.add_child(text_label)
	await get_tree().process_frame
	_history_scroll_container.get_v_scroll_bar().value = _history_scroll_container.get_v_scroll_bar().max_value

func enable_terminal():
	Logger.debug(name, "Enabling the terminal.")
	get_tree().paused = true
	_command_input.grab_focus()
	visible = true
	_history_scroll_container.get_v_scroll_bar().value = _history_scroll_container.get_v_scroll_bar().max_value

func disable_terminal():
	Logger.debug(name, "Disabling the terminal.")
	get_tree().paused = false
	_command_input.release_focus()
	visible = false
#endregion

#region Event Listeners
func _process_command(raw_command: String):
	if raw_command.strip_edges().is_empty():
		return
	Logger.debug(name, "Running command '{0}'.".format([raw_command]))
	if _command_history.size() > 50:
		_command_history.pop_front()
	_command_history.append(raw_command)
	_history_indx = _command_history.size()
	terminal_print("> {0}".format([raw_command]))
	var command_split := raw_command.split(" ")
	
	_command_input.text = ""
	var command = get_command(command_split[0])
	if command == null:
		terminal_print("The command '{0}' does not exist.".format([command_split[0]]), PrintType.Error)
		return
	command_split.remove_at(0)
	command.run(command_split, self)

func _on_close():
	disable_terminal()

func _on_send():
	_process_command(_command_input.text)
#endregion
