extends CharacterBody2D

@export var speed = 100
var enemy = null
var player_chase = true
var player = null
func _ready():
	player = $"../../Player/CharacterBody2D"
	
var moving = false
var target

func _physics_process(delta):
	
	player_chase = true
	var enemies = []
	for area in player.get_enemies():
		if "Enemy" in area.get_groups():
			player_chase = false
			enemies.append(area)
		
	if player_chase:
		target = player.global_position + (global_position - player.global_position).normalized() * 30
	else:
		print("chasing")
		enemy = enemies[0]
		target = enemy.global_position + (global_position - enemy.global_position).normalized() * 30
		
	
	$Node2D/NavigationAgent2D.target_position = target
	if (global_position - target).length_squared() > 1 and $Node2D/NavigationAgent2D.is_target_reachable():

		var vel = $Node2D/NavigationAgent2D.get_next_path_position() - global_position
		velocity = vel.normalized() * speed
		
		if vel.x < 0:
			$Node2D.scale.x = -1
		elif vel.x >= 0:
			$Node2D.scale.x = 1
			
		if !moving:
			$Node2D/AnimatedSprite2D.play("run")
			moving = true
			
		move_and_slide()
	else:
		if player_chase:
			moving = false
			$Node2D/AnimatedSprite2D.play("idle")
		
	if !player_chase and global_position.distance_to(target) <= 50:	
		if enemy.get_parent().enemyHealth >= 0:
			enemy.get_parent().enemyHealth -= .1
	pass
