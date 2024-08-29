extends Node

# Child Nodes
## UI
@onready var start_message = get_node("UI/Start Message")
@onready var player_one_score_label = get_node("UI/Player One Score")
@onready var player_two_score_label = get_node("UI/Player Two Score")
@onready var win_message = get_node("UI/Win Message")

## Game
@onready var field = get_node("Game/Field")
@onready var player_one = get_node("Game/Player One")
@onready var player_two = get_node("Game/Player Two")
@onready var ball = get_node("Game/Ball")

# Constants
const WIN_CONDITION = 10

# Variables
var player_one_score : int
var player_two_score : int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Set up scores
	player_one_score = 0
	player_two_score = 0
	field.get_node("Left Goal").body_entered.connect(_on_p2_scored)
	field.get_node("Right Goal").body_entered.connect(_on_p1_scored)
	
	# Display start message
	for step in range(0, 100):
		var alpha = step / 100.0
		start_message.label_settings.set_font_color(Color(1, 1, 1, alpha))
		await get_tree().create_timer(0.02).timeout

	# Hide start message
	for step in range(0, 100):
		var alpha = abs(step - 100) / 100.0
		start_message.label_settings.set_font_color(Color(1, 1, 1, alpha))
		await get_tree().create_timer(0.02).timeout
		
	ball.throw(ball.Throw.LEFT)

func _on_p2_scored(body : Node2D) -> void:
	if body.name != "Ball":
		return	
	
	player_two_score += 1
	player_two_score_label.text = str(player_two_score)
	
	if player_two_score < WIN_CONDITION:
		ball.reset()
		ball.throw(ball.Throw.LEFT)
	else:
		win_message.text = "PLAYER 2 WINS!"
		win_message.label_settings.set_font_color(Color(1, 1, 1, 1))
	
func _on_p1_scored(body : Node2D) -> void:
	if body.name != "Ball":
		return
		
	player_one_score += 1
	player_one_score_label.text = str(player_one_score)	
	
	if player_one_score < WIN_CONDITION:
		ball.reset()
		ball.throw(ball.Throw.RIGHT)
	else:
		win_message.text = "PLAYER 1 WINS!"
		win_message.label_settings.font_color = Color(1, 1, 1, 1)
