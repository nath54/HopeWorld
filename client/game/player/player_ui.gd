extends Control

var player = null;

func set_life():
	if player == null:
		return
	
	$in_game/VBoxContainer/Control/life.value = int((player.vie/player.vie_tot)*100.0)
	$in_game/VBoxContainer/Control/life/Label.text = str(player.vie)+"/"+str(player.vie_tot)

func set_stamina():
	if player == null:
		return
	$in_game/VBoxContainer/Control2/stamina.value = int((player.stamina/player.stamina_max)*100.0)

func _input(event):
	if Input.is_action_just_pressed("menu"):
		if Global.pause:
			Global.pause=false;
			$pause_menu.visible = false;
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			if player != null:
				player.resume()
		else:
			Global.pause=true;
			$pause_menu.visible = true;
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			if player != null:
				player.pause()



func _on_Bt_store_pressed():
	pass # Replace with function body.


func _on_Bt_perso_pressed():
	pass # Replace with function body.


func _on_Bt_inv_pressed():
	pass # Replace with function body.


func _on_Bt_quest_pressed():
	pass # Replace with function body.


func _on_Bt_map_pressed():
	pass # Replace with function body.


func _on_Bt_web_pressed():
	 OS.shell_open("http://hopeworld.cerisara.fr");


func _on_Bt_help_pressed():
	pass # Replace with function body.


func _on_bt_main_menu_pressed():
	#TODO : faire les sauvegardes
	get_tree().change_scene("res://menu/main.tscn")


func _on_bt_quit_pressed():
	#TODO : faire les sauvegardes
	get_tree().quit()
