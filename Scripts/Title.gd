extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _game_start():
	get_tree().change_scene("res://Scenes/Minigame_Session.tscn")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$Button.connect("pressed",self,"_game_start")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
