extends "res://Scripts/minigame.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here

	$object.position.y = 10
	pass

func minigame_start():
	$object.set_process(true)
	.minigame_start()
	pass
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
