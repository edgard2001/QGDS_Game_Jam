extends CharacterBody2D

# Speed of the character
var speed = 200
@export var health = 100
@export var canvas : CanvasLayer
@export var enemyAttacking = false

var tilemap: TileMap
func _ready():
	tilemap = $"../../TileMap"

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
	var healthLabel = $"../CanvasLayer/HBoxContainer/VBoxContainer2/Label5" 
	healthLabel.text = str(health)
	velocity = input_vector * speed
	# Move the character
	move_and_slide()

func _dead():
	speed = 0
	$"../CanvasLayer"._deathScreen()
	
func _on_area_2d_area_entered(area):
	if "tree" in area.get_groups():
		var pos = tilemap.local_to_map(area.position)
		
		tilemap.set_cell(1, pos, 2, tilemap.get_cell_atlas_coords(1, pos) + Vector2i(0, 0))
		print(tilemap.get_cell_atlas_coords(1, pos) + Vector2i(3, -1))
		tilemap.set_cell(1, pos + Vector2i(-1, -1))
		print(tilemap.get_cell_atlas_coords(1, pos) + Vector2i(3, -1))
		tilemap.set_cell(1, pos + Vector2i(0, -1), 2, tilemap.get_cell_atlas_coords(1, pos) + Vector2i(3, -1))
		tilemap.set_cell(1, pos + Vector2i(1, -1))
		
		tilemap.set_cell(1, pos + Vector2i(-1, -2))
		tilemap.set_cell(1, pos + Vector2i(0, -2))
		tilemap.set_cell(1, pos + Vector2i(1, -2))
		
		tilemap.set_cell(1, pos + Vector2i(-1, -3))
		tilemap.set_cell(1, pos + Vector2i(0, -3))
		tilemap.set_cell(1, pos + Vector2i(1, -3))
		
		tilemap.set_cell(2, pos)


func _on_area_2d_2_area_entered(area):
	if "Enemy" in area.get_groups():
		enemyAttacking = true
		print_debug(enemyAttacking)
	else:
		enemyAttacking = false
		print_debug(enemyAttacking)
	pass # Replace with function body.
