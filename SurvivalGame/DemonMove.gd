extends CharacterBody2D

var speed = 150
var player

func _ready():
	player = get_node("/root/MainScene/Player")  # Adjust the path based on your scene structure

func _process(delta):
	var direction = (player.global_position - global_position).normalized()
	var velocity = direction * speed
	move_and_slide()
