extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var debug_mode = false
var difficulty = 0
var current_points = 0

var max_points = [0,0,0,0]

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
	
func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://godotware2.save"):
		return
	save_game.open("user://godotware2.save", File.READ)
	var content = save_game.get_as_text()
	save_game.close()
	var save = JSON.parse(content)
	if (save.result):
		max_points[0] = save.result.easy
		max_points[1] = save.result.medium
		max_points[3] = save.result.hard
		max_points[4] = save.result.impossible
	pass
	
func save():
	if not debug_mode:
		if current_points > max_points[difficulty-1]:
			max_points[difficulty-1] = current_points
	var save_dict = {
		"easy": max_points[0],
		"medium": max_points[1],
		"hard": max_points[2],
		"impossible": max_points[3],
	}
	var save_game = File.new()
	if not save_game.file_exists("user://godotware2.save"):
		save_game.open("user://godotware2.save", File.WRITE)
	else:
		save_game.open("user://godotware2.save", File.READ_WRITE)
	save_game.store_line(to_json(save_dict))
	save_game.close()
	return
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
