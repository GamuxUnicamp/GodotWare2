extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
signal pressed(difficulty)

func _easy():
	emit_signal("pressed",1)

func _medium():
	emit_signal("pressed",2)
	
func _hard():
	emit_signal("pressed",3)
	
func _impossible():
	emit_signal("pressed",4)

func _ready():
	$Easy.connect("pressed",self,"_easy")
	$Medium.connect("pressed",self,"_medium")
	$Hard.connect("pressed",self,"_hard")
	$Impossible.connect("pressed",self,"_impossible")
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
