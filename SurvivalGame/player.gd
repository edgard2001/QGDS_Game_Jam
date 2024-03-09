extends CharacterBody2D

# Speed of the character
var speed = 200
var health = 100
@export var canvas : CanvasLayer

var tilemap: TileMap
func _ready():
	tilemap = $"../../TileMap"

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
		_dead()
	
	velocity = input_vector * speed
	# Move the character
	move_and_slide()
	
	if Input.is_action_just_pressed("Chop") and tree != null:
		var text = $"../CanvasLayer/HBoxContainer/VBoxContainer2/Label2".text
		$"../CanvasLayer/HBoxContainer/VBoxContainer2/Label2".text = str(int(text) + 1)
		if tree.take_damage(40): 
			var pos = tilemap.local_to_map(tree.position)
			
			tilemap.set_cell(1, pos, 2, tilemap.get_cell_atlas_coords(1, pos) + Vector2i(0, 0))

			tilemap.set_cell(1, pos + Vector2i(-1, -1))
			tilemap.set_cell(1, pos + Vector2i(0, -1), 2, tilemap.get_cell_atlas_coords(1, pos) + Vector2i(3, -1))
			tilemap.set_cell(1, pos + Vector2i(1, -1))
			
			tilemap.set_cell(1, pos + Vector2i(-1, -2))
			tilemap.set_cell(1, pos + Vector2i(0, -2))
			tilemap.set_cell(1, pos + Vector2i(1, -2))
			
			tilemap.set_cell(1, pos + Vector2i(-1, -3))
			tilemap.set_cell(1, pos + Vector2i(0, -3))
			tilemap.set_cell(1, pos + Vector2i(1, -3))
			
			tilemap.set_cell(2, pos)
	

func _dead():
	speed = 0
	$"../CanvasLayer"._deathScreen()
	
var tree: Area2D
	
func _on_area_2d_area_entered(area):
	if "tree" in area.get_groups():
		tree = area

func _on_area_2d_area_exited(area):
	if "tree" in area.get_groups():
		tree = null
