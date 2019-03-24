extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var difficulties = ["EASY","MEDIUM","HARD","IMPOSSIBLE"]

func _restart_game():
	get_tree().change_scene("res://Scenes/Title.tscn")
	pass

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	global.save()
	if global.debug_mode:
		$debug.show()
	$Points.text = "SCORE: "+str(global.current_points)
	$High_score.text = "HIGHSCORE: "+str(global.max_points[global.difficulty-1])
	$Difficulty.text = difficulties[global.difficulty-1]
	$Button.connect("pressed",self,"_restart_game")
	pass


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
