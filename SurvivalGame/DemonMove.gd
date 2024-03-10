extends CharacterBody2D

@export var speed = 80
var player_chase = true
var player = null
var playerNode = null
@export var enemyHealth = 30
func _ready():
	player = $"../../Player/CharacterBody2D"
	playerNode = $"../../Player"
func _physics_process(delta):
	#if player_chase:
		#
		#global_position += (player.global_position - global_position) * speed * delta
		#move_and_slide()
	if global_position.distance_to(player.global_position) <= 45:
		if player.health >= 1:
			player.health -= 1
	#else:
		#speed = 2
	#if enemyHealth <= 0:
		#queue_free()
		
	var target = player.global_position + (global_position - player.global_position).normalized() * 20
	$NavigationAgent2D.target_position = target
	if (global_position - target).length_squared() > 1 and $NavigationAgent2D.is_target_reachable():

		var vel = $NavigationAgent2D.get_next_path_position() - global_position
		velocity = vel.normalized() * speed
			
		move_and_slide()
