class_name MetricsOverlay
extends PanelContainer

@onready var fps_label = $ClientSection/Vbox/FPSLabel

func _process(_delta):
	if visible:
		var fps := Engine.get_frames_per_second()
		fps_label.text = "FPS: {0}".format([fps])
