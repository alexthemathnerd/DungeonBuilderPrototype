class_name Logger
extends RefCounted

#region Enums
enum Severity { INFO, DEBUG, WARNING, ERROR }
#endregion

#region Public Methods
static func log(src: String, msg: String, severity: Severity):
	if severity == Severity.DEBUG and not OS.is_debug_build():
		return
	var color 
	match severity:
		Severity.INFO:
			color = "white"
		Severity.DEBUG:
			color = "gray"
		Severity.WARNING:
			color = "orange"
		Severity.ERROR:
			color = "red"
	print_rich("[{0}] [color={1}]{2}: {3}[/color]".format([src.to_snake_case().to_upper(), color, Severity.keys()[severity], msg]))

static func info(src: String, msg: String):
	Logger.log(src, msg, Severity.INFO)

static func debug(src: String, msg: String):
	Logger.log(src, msg, Severity.DEBUG)

static func warning(src: String, msg: String):
	Logger.log(src, msg, Severity.WARNING)

static func error(src: String, msg: String):
	Logger.log(src, msg, Severity.ERROR)
#endregion
