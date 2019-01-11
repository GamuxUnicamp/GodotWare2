extends "res://Scripts/minigame.gd"

onready var view_rect = get_viewport_rect()

func _ready():
	randomize()
	$Limite.connect("area_entered",self,"artigo_entrou")
	$Artigo.connect("body_entered",self,"player_pegou")
	$Artigo.position = Vector2(randf()*(view_rect.size.x-50)+25,-18)
	pass

func player_pegou(body):
	if body == $Player:
		$Artigo.position = Vector2(randf()*(view_rect.size.x-50)+25,-18)

func artigo_entrou(area):
	if area == $Artigo:
		print("GG noob")
		timer_pause()
		emit_signal("minigame_end",false)

func minigame_start():
	$Player.set_process(true)
	$Artigo.set_process(true)
	.minigame_start()
	pass
	
func _process(delta):
	pass

