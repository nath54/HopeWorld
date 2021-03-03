extends Spatial

func _ready():
	intro()

func intro():
	pass

func fin_intro():
	Global._send({"type": "intro_finie"})
	get_tree().change_scene()
