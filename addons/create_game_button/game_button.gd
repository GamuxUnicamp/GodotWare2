tool
extends Button

var counter = 1

func _pressed():
	if pressed:
		var new_window = load("res://addons/create_game_button/Minigame_Creator.tscn").instance()
		print("created "+str(counter))
		counter+=1
		add_child(new_window)
		new_window.popup()
	pass

func _ready():
	print("banana ready")
	pass
