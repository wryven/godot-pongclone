extends AnimatableBody2D

# TODO: Make it so stamina start regen after some seconds.

# Child Nodes
@onready var collision_shape = $"Collision Shape"
@onready var sprite = $"Sprite"
@onready var stamina_meter = $"Stamina Meter"

# Resources
@export var _paddle : Paddle
@export var _behaviour : EnemyBehaviour

# Variables

## Position
var _initial_position : Vector2

## Movement
var _direction : Vector2
var _speed : float

## Stamina
var _stamina : float

# Primary functions

func _ready() -> void:
	# Override collision and sprite with paddle's 
	collision_shape.shape = _paddle.shape
	sprite.texture = _paddle.texture
	
	# Initialize variables
	_initial_position = position
	_direction = Vector2.ZERO
	_speed = 0.0
	_stamina = _paddle.max_stamina
	
func _process(delta: float) -> void:
	# Handle stamina usage
	if !is_idle() && is_turbo_active() && has_enough_stamina():
		_stamina -= _paddle.stamina_usage

	# Handle stamina regen
	elif _stamina < _paddle.max_stamina:
		if is_idle():
			_stamina += _paddle.stamina_regen * _paddle.idle_multiplicator
		else:
			_stamina += _paddle.stamina_regen
	
	# Update stamina meter
	stamina_meter.text = str(_stamina)


func _physics_process(delta: float) -> void:
	# Lock player's x position
	position.x = _initial_position.x
	
	# Move player towards direction
	if _direction:
		constant_linear_velocity = _direction * _speed * delta
	else:
		constant_linear_velocity.y = move_toward(constant_linear_velocity.y, 0, _speed)
	
	move_and_collide(constant_linear_velocity)


# Helper functions

func has_enough_stamina() -> bool:
	return _stamina >= _paddle.stamina_usage


func is_idle() -> bool:
	return constant_linear_velocity == Vector2.ZERO

func is_turbo_active() -> bool:
	return _speed == _paddle.turbo_speed
