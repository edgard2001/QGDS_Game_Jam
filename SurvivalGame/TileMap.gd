extends TileMap

@export var TreeTrunkTileCoords = Vector2i(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	#for pos in get_used_cells(1):
	#	if get_cell_atlas_coords(1, pos) == TreeTrunkTileCoords:
	#		set_cell(1, pos, 2, TreeTrunkTileCoords + Vector2i(0, -1))
	
	var noise = FastNoiseLite.new()

	# Configure
	noise.seed = randi()
	noise.frequency = 0.1
 
	var limits: Rect2i = get_used_rect()
	for pos in get_used_cells(0):
		var x = float(pos.x - limits.position.x + 0.5)
		var y = float(pos.y - limits.position.y + 0.5) 
		if noise.get_noise_2d(x, y) > 0.3:
			set_cell(1, pos, 2, Vector2i(20, 4))
			set_cell(2, pos, 0, Vector2i(0,0), 1)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
