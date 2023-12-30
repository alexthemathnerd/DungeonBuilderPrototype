class_name DebugHideCommand
extends Command

func _init():
	name = "debug_hide"
	description = "Hide a debug overlay. See the 'debug_show' command."
	usage = "debug_hide [context|metrics]"

func run(args: Array[String], terminal: DebugTerminal):
	if args.is_empty():
		_hide_context(terminal)
		_hide_metrics(terminal)
		return
	match args[0]:
		"context":
			_hide_context(terminal)
		"metrics":
			_hide_metrics(terminal)
		_:
			terminal.terminal_print("{0} is not a viewable debug display.".format([args[0]]), DebugTerminal.PrintType.Error)

func _hide_context(terminal: DebugTerminal):
	if Global.dungeon_context == null:
		terminal.terminal_print("", DebugTerminal.PrintType.Error)
		return
	Global.game.get_debug_display().disable_dungeon_context_overlay()

func _hide_metrics(_terminal: DebugTerminal):
	Global.game.get_debug_display().disable_metrics_overlay()
