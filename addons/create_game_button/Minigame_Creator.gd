tool
extends PopupMenu

var template = "res://Scripts/Template/Main.gd"
const minigame_path = "res://Minigames"
var mouse_over = false

func _mouse_over(opt):
	print(opt)
	mouse_over = opt


func _ready():
	$Button.connect("pressed",self,"create_game")

func create_game():
	var directory = Directory.new()
	if directory.open(minigame_path) == OK:
		var name = $Name.text
		name = name.replace(" ","_")
		directory.make_dir(name)
		directory.open(name)
		var game_address = minigame_path+'/'+name
		directory.copy(template,game_address+"/Main.gd")
		var new_game = Node2D.new()#load(game_address+"/Main.gd").new()
		new_game.set_script(load(game_address+"/Main.gd"))
		new_game.name = "Main"
		new_game.NAME = name
		new_game.INSTRUCTION = $Instruction.text
		new_game.DURATION = float($Duration.text.replace(",","."))
		new_game.TIMEOUT_WIN = $Timeout.pressed
		var packed_scene = PackedScene.new()
		packed_scene.pack(new_game)
		ResourceSaver.save(game_address+"/Main.tscn",packed_scene)
		pass
	hide()
	queue_free()
	pass