extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func hide():
	for child in get_children():
		if child.has_method("hide"):
			child.hide()
			
func show():
	for child in get_children():
		if child.has_method("show"):
			child.show()
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
