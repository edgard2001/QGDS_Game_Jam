extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	var deathLabel : Label = $VBoxContainer/Label
	deathLabel.visible = false
	var mainMenuButton : Button = $VBoxContainer2/Button
	mainMenuButton.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _deathScreen():
	var deathLabel : Label = $VBoxContainer/Label
	deathLabel.visible = true
	var mainMenuButton : Button = $VBoxContainer2/Button
	mainMenuButton.visible = true
