extends Node2D

export(String) var NAME = "Template"

export(String) var INSTRUCTION = "DO IT!"

export(int) var DURATION = 5

export(int) var TIMEOUT_WIN = false

export(bool) var USE_KEYBOARD = false

export(bool) var USE_MOUSE = true

onready var difficulty = global.difficulty
var timer

signal minigame_end(cond)
signal timer_percentage(remaining)
# class member variables go here, for example:
# var a = 2
# var b = "textvar"
func _on_minigame_end_timeout():
	emit_signal("minigame_end",TIMEOUT_WIN)
	pass


func _ready():
	timer = Timer.new()
	timer.connect("timeout",self,"_on_minigame_end_timeout")
	timer.set_one_shot(true)
	timer.name = "Minigame_Timer"
	add_child(timer)
	set_process(false)
	set_physics_process(false)
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func timer_pause():
	timer.set_paused(true)

func timer_resume():
	timer.set_paused(false)

func minigame_start():
	timer.wait_time = DURATION
	set_process(true)
	timer.start()
	pass

func _process(delta):
	emit_signal("timer_percentage", 100*timer.get_time_left()/DURATION)
	pass
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
