extends CharacterBody2D

@export var speed = 3
var enemey = null
var player_chase = true
var player = null
func _ready():
	player = $"../../Player/CharacterBody2D"
func _physics_process(delta):
	if player.enemyAttacking == true:
		enemey = $"../../Demon/CharacterBody2D"
		player_chase = false
	else:
		player_chase = true
	if player_chase:
		global_position += (player.global_position - global_position) * speed * delta
		move_and_slide()
	else:
		global_position += (enemey.global_position - global_position) * speed * delta
		move_and_slide()
		if global_position.distance_to(enemey.global_position) <= 50:
			
			speed = 1
			if enemey.enemyHealth >= 1:
				print_debug(enemey.enemyHealth)
				enemey.enemyHealth -= 1
		else:
			speed = 3
	
	
