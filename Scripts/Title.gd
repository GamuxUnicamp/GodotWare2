extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var locked_level
var infinite_lives

var current_lives = 3
var current_minigame = null
var last_minigame_index = -1

func show_lives():
	pass
	
func _debug_start(options):
	locked_level = options["level"]
	infinite_lives = options["infinite_lives"]
	global.debug_mode = true
	_game_start(options["difficulty"])
	pass


func _debug_pressed():
	$Debug_menu/ChooseLevel.show()

func _minigame_ended(status):
	$Game_UI.hide()
	if status == true:
		global.current_points += 1
	else:
		current_lives -= 1
	Engine.set_time_scale(global.time_increase(global.current_points))
	led_print("")
	$Close_out.play("Close_out")
	
	pass

func _update_progress_bar(value):
	$Game_UI/ProgressBar.value = value
	pass

func _game_start(difficulty):
	if global.debug_mode:
		print("starting game in debug mode")
	global.difficulty = difficulty
	$Buttons.queue_free()
	led_print("")
	$Close_Door.play("Close")
	pass

func led_print(instruction):
	$BG/Label.text = instruction
	#get_tree().change_scene("res://Scenes/Minigame_Session.tscn")

func _ready():
	Engine.set_time_scale(global.time_increase(global.current_points))
	global.current_points = 0
	global.debug_mode = false
	randomize()
	$Game_UI.hide()
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$Debug_menu/ChooseLevel.connect("start_debug",self,"_debug_start")
	$BG.frame = 0
	$Buttons/Easy.connect("pressed",self,"_game_start",[1])
	$Buttons/Medium.connect("pressed",self,"_game_start",[2])
	$Buttons/Hard.connect("pressed",self,"_game_start",[3])
	$Buttons/Impossible.connect("pressed",self,"_game_start",[4])
	$Buttons/Debug.connect("pressed",self,"_debug_pressed")
	$Close_Door.connect("animation_finished",self,"_door_closed")
	$Open_Door.connect("animation_finished",self,"_door_open")
	$Close_in.connect("animation_finished",self,"_zoom_in")
	$Close_out.connect("animation_finished",self,"_zoom_out")
	$Delay_timer.connect("timeout",self,"_delay_timeout")
	pass

func _door_closed(anim):
	if global.debug_mode and infinite_lives:
		pass
	elif current_lives <= 0:
		get_tree().change_scene("res://Scenes/Game_over.tscn")
	if current_minigame != null:
		current_minigame.queue_free()
	$Delay_timer.start()
	show_lives()
	pass

func _delay_timeout():
	var game_number = global.minigame_list.size()
	if game_number >= 1:
		if global.debug_mode:
			current_minigame = global.minigame_list[locked_level].instance()
		else:
			var next_minigame_index = randi()%game_number
			while next_minigame_index == last_minigame_index:
				next_minigame_index = randi()%game_number
			last_minigame_index = next_minigame_index
			current_minigame = global.minigame_list[next_minigame_index].instance()
		print("Lives: "+str(current_lives))
		print("Score: "+str(global.current_points))
		print("Speed: "+str(Engine.get_time_scale()))
		print("Difficulty: "+str(global.difficulty))
		print("Starting: " + current_minigame.NAME)
		add_child(current_minigame)
		current_minigame.connect("timer_percentage",self,"_update_progress_bar")
		current_minigame.connect("minigame_end",self,"_minigame_ended")
		led_print(current_minigame.INSTRUCTION)
		$Open_Door.play("Open")
	pass
	
func _door_open(anim):
	$Close_in.play("Close_in")
	pass
	
func _zoom_in(anim):
	$Game_UI.show()
	print("deu zoom in")
	current_minigame.minigame_start()
	pass

func _zoom_out(anim):
	$Close_Door.play("Close")
	pass
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
