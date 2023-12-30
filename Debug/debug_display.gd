class_name DebugDisplay
extends Control

@onready var _dungeon_context_overlay = $DungeonContextOverlay
@onready var _metrics_overlay = $MetricsOverlay

func enable_dungeon_context_overlay():
	_dungeon_context_overlay.visible = true

func disable_dungeon_context_overlay():
	_dungeon_context_overlay.visible = false

func enable_metrics_overlay():
	_metrics_overlay.visible = true

func disable_metrics_overlay():
	_metrics_overlay.visible = false
