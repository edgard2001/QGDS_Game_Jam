extends Area2D

var health: float
const MAX_HEALTH: float = 100;
# Called when the node enters the scene tree for the first time.
func _ready():
	health = MAX_HEALTH
	$ProgressBar.value = health / MAX_HEALTH * 100
	$ProgressBar.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func take_damage(damage: float) -> bool:
	health -= damage
	if health < 0:
		health = 0
	$"ProgressBar".value = health / MAX_HEALTH * 100
	if health == 0:
		$"../AnimatedSprite2D".frame = 1
		$ProgressBar.visible = false
		monitorable = false
		$"../CollisionShape2D".disabled = true
	return health == 0
	
