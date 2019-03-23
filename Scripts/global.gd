extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var debug_mode = false
var difficulty = 0
var current_points = 0

var minigame_list = []
var minigame_names = []
const minigame_path = "res://Minigames"

func time_increase(points):
	return 1.0 +points/10.0
	#return 1.0+sqrt(points/5.0)

func get_minigame_list():
	var minigame_dir = Directory.new()
	if minigame_dir.open(minigame_path) == OK:
		minigame_dir.list_dir_begin()
		var game_name = minigame_dir.get_next()
		while game_name != "":
			if minigame_dir.current_is_dir() and game_name != '.' and game_name != '..':
				if minigame_dir.file_exists(game_name+"/Main.tscn"):
					print("Game_exists "+game_name)
					minigame_list.append(load(minigame_path+"/"+game_name+"/Main.tscn"))
					minigame_names.append(game_name)
				else:
					print("No")
				pass
			game_name = minigame_dir.get_next()
	pass

func _ready():
	get_minigame_list()
	#print(minigame_list)
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
