extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text
signal start_debug(info);

func _start_debug(difficulty):
	print(difficulty)
	var options = {}
	options["difficulty"] = difficulty
	options["infinite_lives"] = $Life_check_button.pressed
	options["level"] = $Minigame_select.selected
	emit_signal("start_debug",options)
	hide()
	pass

func back():
	hide()
	pass
# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/Easy.connect("pressed",self,"_start_debug",[1])
	$VBoxContainer/Medium.connect("pressed",self,"_start_debug",[2])
	$VBoxContainer/Hard.connect("pressed",self,"_start_debug",[3])
	$VBoxContainer/Impossible.connect("pressed",self,"_start_debug",[4])
	$Back.connect("pressed",self,"back")
	for i in range(len(global.minigame_names)):
		$Minigame_select.add_item(global.minigame_names[i],i)
		pass
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
