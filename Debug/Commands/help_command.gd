class_name HelpCommand
extends Command

func _init():
	name = "help"
	description = "Shows this message."
	usage = "help [command]"

func run(args: Array[String], terminal: DebugTerminal):
	if args.is_empty():
		for command: Command in terminal.commands:
			terminal.terminal_print("{0} - {1}".format([command.name, command.description]))
		return
	var command: Command = terminal.get_command(args[0])
	if command != null:
		terminal.terminal_print(args[0])
		terminal.terminal_print(description, DebugTerminal.PrintType.Hint)
		terminal.terminal_print("Usage: {0}".format([usage]))
	else:
		terminal.terminal_print("The command '{0}' does not exist.".format([args[0]]), DebugTerminal.PrintType.Error)
