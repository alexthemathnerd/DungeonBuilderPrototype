class_name DisplayCommand
extends Command

func _init():
	name = "display"
	description = "display debug information"
	usage = "display <dungeon | performance | all>"

func run(args: Array[String], terminal: DebugTerminal):
	if args.is_empty():
		terminal.terminal_print("Missing display type.", DebugTerminal.PrintType.Error)
		return
	
	match args[0]:
		"dungeon":
			if Global.dungeon_context == null:
				terminal.terminal_print("Can't display dungeon data.", DebugTerminal.PrintType.Error)
				return
			Global.game.enable_dungeon_display()
		"performance":
			pass
		"all":
			pass
		_:
			terminal.terminal_print("'{0}' is not a valid display type.".format([args[0]]), DebugTerminal.PrintType.Error)
