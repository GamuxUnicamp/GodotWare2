extends "res://Scripts/minigame.gd"

var game_started = false
var gun_up = false

var stopped = false

func _input(event):
	if event.is_pressed() and stopped == false:
		stopped = true
		timer_pause()
		$Wait_timer.stop()
		$Shot_timer.stop()
		if gun_up:
			$AnimatedSprite.animation = "win"
		else:
			$AnimatedSprite.animation = "missed"
		$End_timer.start()
		pass
	pass

func _ready():
	randomize()
	if difficulty == 1:
		$Shot_timer.wait_time = 2.5
	elif difficulty == 2:
		$Shot_timer.wait_time = 2
	elif difficulty == 3:
		$Shot_timer.wait_time = 1.5
	elif difficulty == 4:
		$Shot_timer.wait_time = 1.0
	print($Shot_timer.wait_time)
	$Wait_timer.wait_time = 0.5+randf()*(DURATION-0.5-$Shot_timer.wait_time-0.1)
	$Wait_timer.connect("timeout",self,"_wait_timer_timeout")
	$Shot_timer.connect("timeout",self,"_shot_timer_timeout")
	$End_timer.connect("timeout",self,"_end_timer_timeout")
	pass

func _wait_timer_timeout():
	$AnimatedSprite.animation = "ready"
	gun_up = true
	$Shot_timer.start()

func _shot_timer_timeout():
	stopped = true
	timer_pause()
	$AnimatedSprite.animation = "bang"
	gun_up = false
	$End_timer.start()

func _end_timer_timeout():
	emit_signal("minigame_end",gun_up)

func minigame_start():
	set_process_input(true)
	game_started = true
	$Wait_timer.start()
	.minigame_start()
	pass
	
func _process(delta):
	pass

