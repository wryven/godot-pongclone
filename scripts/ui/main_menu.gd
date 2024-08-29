extends Control

signal singleplayer_pressed
signal multiplayer_pressed
signal settings_pressed
signal exit_pressed

func _on_singleplayer_pressed() -> void:
	singleplayer_pressed.emit()

func _on_multiplayer_pressed() -> void:
	multiplayer_pressed.emit()

func _on_settings_pressed() -> void:
	settings_pressed.emit()

func _on_exit_pressed() -> void:
	exit_pressed.emit()
