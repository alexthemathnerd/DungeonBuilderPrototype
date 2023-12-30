class_name DebugShowCommand
extends Command

func _init():
	name = "debug_show"
	description = "Shows an overlay with debug infromation, such as the dungeon context and performance metrics."
	usage = "debug_show [context|metrics]>"

func run(args: Array[String], terminal: DebugTerminal):
	if args.is_empty():
		_show_context(terminal)
		_show_metrics(terminal)
		return
	match args[0]:
		"context":
			_show_context(terminal)
		"metrics":
			_show_metrics(terminal)
		_:
			terminal.terminal_print("{0} is not a viewable debug display.".format([args[0]]), DebugTerminal.PrintType.Error)

func _show_context(terminal: DebugTerminal):
	if Global.dungeon_context == null:
		terminal.terminal_print("A dungeon must be loaded to display it's context.", DebugTerminal.PrintType.Error)
		return
	Global.game.get_debug_display().enable_dungeon_context_overlay()

func _show_metrics(_terminal: DebugTerminal):
	Global.game.get_debug_display().enable_metrics_overlay()
