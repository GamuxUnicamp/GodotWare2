extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
func _restart_game():
	get_tree().change_scene("res://Scenes/Title.tscn")
	pass

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	if global.debug_mode:
		$debug.show()
	$Points.text = "SCORE: "+str(global.current_points)
	$Button.connect("pressed",self,"_restart_game")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
