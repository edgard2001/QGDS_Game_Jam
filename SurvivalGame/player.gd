extends CharacterBody2D

# Speed of the character
var speed = 200
var health = 100
@export var canvas : CanvasLayer

func _process(delta):
	# Read input
	var input_vector = Vector2.ZERO
	input_vector.x =  Input.get_action_strength("MoveRight") -Input.get_action_strength("MoveLeft")
	input_vector.y = Input.get_action_strength("MoveDown") - Input.get_action_strength("MoveUp")
	
	if Input.is_action_pressed("SewerSlide"):
		print_debug("bracket")
		health = 0
		print_debug(health)
	# Normalize input vector to avoid moving faster diagonally
	if input_vector.length() > 1:
		input_vector = input_vector.normalized()
		
	if health <=0:
		_dead()
	
	velocity = input_vector * speed
	# Move the character
	move_and_slide()
func _dead():
	speed = 0
	$"../CanvasLayer"._deathScreen()
