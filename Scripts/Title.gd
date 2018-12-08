extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var current_lives = 3
var current_minigame = null
var last_minigame_index = -1

func show_lives():
	pass

func _minigame_ended(status):
	if status == true:
		global.current_points += 1
	else:
		current_lives -= 1
	led_print("")
	$Close_out.play("Close_out")
	pass

func _update_progress_bar(value):
	$Game_UI/ProgressBar.value = value
	pass

func _game_start():
	$Button.queue_free()
	led_print("")
	$Close_Door.play("Close")
	pass

func led_print(instruction):
	$BG/Label.text = instruction
	#get_tree().change_scene("res://Scenes/Minigame_Session.tscn")

func _ready():
	global.current_points = 0
	randomize()
	$Game_UI.hide()
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$BG.frame = 0
	$Button.connect("pressed",self,"_game_start")
	$Close_Door.connect("animation_finished",self,"_door_closed")
	$Open_Door.connect("animation_finished",self,"_door_open")
	$Close_in.connect("animation_finished",self,"_zoom_in")
	$Close_out.connect("animation_finished",self,"_zoom_out")
	$Delay_timer.connect("timeout",self,"_delay_timeout")
	pass

func _door_closed(anim):
	if current_lives <= 0:
		get_tree().change_scene("res://Scenes/Game_over.tscn")
	if current_minigame != null:
		current_minigame.queue_free()
	$Delay_timer.start()
	show_lives()
	pass

func _delay_timeout():
	var game_number = global.minigame_list.size()
	if game_number >= 1:
		var next_minigame_index = randi()%game_number
		while next_minigame_index == last_minigame_index:
			next_minigame_index = randi()%game_number
		last_minigame_index = next_minigame_index
		current_minigame = global.minigame_list[next_minigame_index].instance()
		print("Lives: "+str(current_lives))
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
	current_minigame.minigame_start()
	pass

func _zoom_out(anim):
	$Close_Door.play("Close")
	pass
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
