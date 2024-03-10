extends CharacterBody2D

# Speed of the character
var speed = 150
const maxHealth: float = 300
var health: float = 300
@export var canvas : CanvasLayer

var tilemap: TileMap
func _ready():
	tilemap = $"../../TileMap"
	$Node2D/AnimatedSprite2D.animation = "default"
	$Node2D/AnimatedSprite2D.frame = 0


var moving = false
var chopping = false

func _process(delta):
	# Read input
	var input_vector = Vector2.ZERO
	input_vector.x =  Input.get_action_strength("MoveRight") -Input.get_action_strength("MoveLeft")
	input_vector.y = Input.get_action_strength("MoveDown") - Input.get_action_strength("MoveUp")
	
	if input_vector.x < 0:
		$Node2D.scale.x = -1
	elif input_vector.x > 0:
		$Node2D.scale.x = 1
	
	if Input.is_action_pressed("SewerSlide"):
		print_debug("bracket")
		health = 0
		print_debug(health)
	# Normalize input vector to avoid moving faster diagonally
	if input_vector.length() > 1:
		input_vector = input_vector.normalized()
		
	if health <=0:
		health = 0
		_dead()
		
	$ProgressBar.value = health / 3
	
	velocity = input_vector * speed
	# Move the character
	move_and_slide()
	
	
	if chopping and tree != null:
		var text = $"../CanvasLayer/Control/MarginContainer/HBoxContainer/VBoxContainer3/Label2".text
		$"../CanvasLayer/Control/MarginContainer/HBoxContainer/VBoxContainer3/Label2".text = str(int(text) + 1)
		if tree.take_damage(2): 
			tree = null
			
	if Input.is_action_just_pressed("Chop"):
		chopping = true
	elif Input.is_action_just_released("Chop"):
		chopping = false
		
	moving = velocity.length() > 0


func _physics_process(delta):
	if speed == 0:
		return
		
	if moving:
		$Node2D/AnimatedSprite2D.play("run")
	elif !chopping:
		$Node2D/AnimatedSprite2D.animation = "default"
		$Node2D/AnimatedSprite2D.frame = 0

	if chopping:
		$Node2D/AnimatedSprite2D.play("chop")
	

func _dead():
	speed = 0
	$"../CanvasLayer"._deathScreen()
	
var tree: Area2D
	
func _on_area_2d_area_entered(area):
	if tree != null:
		tree.get_child(1).visible = false
		
	if "tree" in area.get_groups():
		tree = area
		area.get_child(1).visible = true
	if "food" in area.get_groups():
		print_debug("apples")
		health += 30
		if health > maxHealth:
			health = maxHealth
		var apple = area.get_parent()
		apple.queue_free()
func _on_area_2d_area_exited(area):
	if "tree" in area.get_groups():
		tree = null
		area.get_child(1).visible = false
