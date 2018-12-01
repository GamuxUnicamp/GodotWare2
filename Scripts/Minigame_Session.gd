extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var current_minigame

func update_progress_bar(value):
	$CanvasLayer/ProgressBar.value = value
	pass

func _ready():
	if global.minigame_list.size() >= 1:
		current_minigame = global.minigame_list[0].instance()
		print("Starting" + current_minigame.NAME)
		add_child(current_minigame)
		current_minigame.connect("timer_percentage",self,"update_progress_bar")
		current_minigame.minigame_start()
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
