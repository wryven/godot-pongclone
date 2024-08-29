extends RigidBody2D

# Child Node
@onready var collision_shape = $"Collision Shape"
@onready var sprite = $"Sprite"

# Resources
@export var _specs : BallSpecs

# Enums
enum Throw { RANDOM = 0, LEFT = -1, RIGHT = 1 }

# Variables

## Position
var _initial_position : Vector2

# Main functions

func _ready() -> void:
	# Override collision and sprite with ball stat's
	collision_shape.shape = _specs.shape
	sprite.texture = _specs.texture
	
	# Initialize variables
	_initial_position = position


func _physics_process(delta: float) -> void:
	# Move and handle bounce
	var collision = move_and_collide(linear_velocity)
	if collision:
		linear_velocity = linear_velocity.bounce(collision.get_normal())
		
		# Use bounce multiplier till reaching maximum speed
		var speed = linear_velocity.length()
		if  speed < _specs.max_speed:
			linear_velocity *= _specs.bounce_multiplier
		
		# Fix over-speed
		if speed > _specs.max_speed:
			linear_velocity = linear_velocity.normalized() * _specs.max_speed


func reset() -> void:
	linear_velocity = Vector2.ZERO
	position = _initial_position
	
	
func throw(throw : Throw) -> void:
	var direction = Vector2.ZERO
	
	# Decide random direction with D6
	if throw == Throw.RANDOM:
		var d6 = randi_range(1, 6)
		if d6 > 3:
			throw = Throw.LEFT
		else:
			throw = Throw.RIGHT	
	
	match throw:
		Throw.LEFT:
			direction.x = -1.0
		Throw.RIGHT:
			direction.x = 1.0
	
	direction.y = randf_range(-0.8, 0.8)
	direction = direction.normalized()
	
	linear_velocity = direction * _specs.initial_speed
