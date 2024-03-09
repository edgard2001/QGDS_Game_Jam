extends CharacterBody2D

# Speed of the character
var speed = 200

func _process(delta):
	# Read input
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("MoveLeft") - Input.get_action_strength("MoveRight")
	input_vector.y = Input.get_action_strength("MoveUp") - Input.get_action_strength("MoveDown")
	
	# Normalize input vector to avoid moving faster diagonally
	if input_vector.length() > 1:
		input_vector = input_vector.normalized()
	
	velocity = input_vector * speed
	# Move the character
	move_and_slide()
