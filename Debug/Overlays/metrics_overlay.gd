class_name MetricsOverlay
extends PanelContainer

@onready var _fps_label = $ClientSection/Vbox/FPSLabel
@onready var _frame_time_label = $ClientSection/Vbox/FrameTimeLabel


func _process(_delta):
	if visible:
		var fps := Performance.get_monitor(Performance.TIME_FPS)
		_fps_label.text = "FPS: {0}".format([fps])
		var frame_time := Performance.get_monitor(Performance.TIME_PROCESS) * 1000
		_frame_time_label.text = "Frame Time: {0} ms".format([frame_time])
