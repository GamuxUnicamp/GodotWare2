extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	set_process(true)
	pass
	
func _process(delta):
	position.x+=delta*100
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
