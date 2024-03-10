extends TileMap

const TREE = preload("res://Tree/Tree.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	#for pos in get_used_cells(1):
	#	if get_cell_atlas_coords(1, pos) == TreeTrunkTileCoords:
	#		set_cell(1, pos, 2, TreeTrunkTileCoords + Vector2i(0, -1))
	
	for pos in get_used_cells(0):
		if randf() < 0.02:
			var tree = TREE.instantiate()
			tree.global_position = map_to_local(pos)
			$NavigationRegion2D.add_child(tree)
			
	$NavigationRegion2D.bake_navigation_polygon()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
