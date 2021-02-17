extends Control

var global = null

# Called when the node enters the scene tree for the first time.
func _ready():
	global = $"/root/Global"

func _on_Button2_pressed():
	 OS.shell_open("http://hopeworld.cerisara.fr");


func _on_Button_pressed():
	var pseudo = $form/pseudo.text
	var password = $form/password.text
	global._send({"type":"connection",
				 "pseudo": pseudo,
				 "password": password})
