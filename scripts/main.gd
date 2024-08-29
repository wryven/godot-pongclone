extends Node

# Enum
enum State { MAINMENU, SINGLEPLAYER, MULTIPLAYER, SETTINGS }

# Scenes
var scene_main_menu = preload("res://scenes/ui/main_menu.tscn")
var scene_multiplayer = preload("res://scenes/game/multiplayer.tscn")

# Variables
var state : State

func _ready() -> void:
	add_child(scene_main_menu.instantiate())
	var main_menu = get_node("Main Menu")
	main_menu.singleplayer_pressed.connect(_on_singleplayer_pressed)
	main_menu.multiplayer_pressed.connect(_on_multiplayer_pressed)
	main_menu.settings_pressed.connect(_on_settings_pressed)
	main_menu.exit_pressed.connect(_on_exit_pressed)
	state = State.MAINMENU
	
func _process(delta: float) -> void:	
	pass
	
func _on_singleplayer_pressed() -> void:
	pass

func _on_multiplayer_pressed() -> void:
	get_node("Main Menu").queue_free()
	add_child(scene_multiplayer.instantiate())
	
func _on_settings_pressed() -> void:
	pass
	
func _on_exit_pressed() -> void:
	get_tree().quit()
