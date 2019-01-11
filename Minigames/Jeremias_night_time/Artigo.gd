extends Area2D


export(int) var SPEED = 200


func _ready():
	set_process(false)
	pass

func _process(delta):
	position.y += SPEED*delta
	pass