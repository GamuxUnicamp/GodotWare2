extends KinematicBody2D

export(int) var SPEED = 400
var normal = Vector2(0,-1)

func _ready():
	add_to_group("Player")
	set_process(false)
	pass
	
func _process(delta):
	var linear_velocity = Vector2(0,0)
	if Input.is_action_pressed("ui_right"):
		linear_velocity.x += SPEED
	if Input.is_action_pressed("ui_left"):
		linear_velocity.x -= SPEED
	move_and_slide(linear_velocity,normal)
	pass
