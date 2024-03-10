extends CharacterBody2D

@export var speed = 100
var enemey = null
var player_chase = true
var player = null
func _ready():
	player = $"../../Player/CharacterBody2D"
	
var moving = false
func _physics_process(delta):
	"""if player.enemyAttacking == true:
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
	"""
	
	var target = player.global_position + (global_position - player.global_position).normalized() * 20
	$Node2D/NavigationAgent2D.target_position = target
	if (global_position - target).length_squared() > 1 and $Node2D/NavigationAgent2D.is_target_reachable():

		var vel = $Node2D/NavigationAgent2D.get_next_path_position() - global_position
		velocity = vel.normalized() * speed
		
		if vel.x < 0:
			$Node2D.scale.x = -1
		elif vel.x > 0:
			$Node2D.scale.x = 1
			
		if !moving:
			$Node2D/AnimatedSprite2D.play("run")
			moving = true
			
		move_and_slide()
	else:
		moving = false
		$Node2D/AnimatedSprite2D.play("idle")
	pass
