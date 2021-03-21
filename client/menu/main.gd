extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$scene_intro/AnimationPlayer.play("Camera_deb")

func _on_Bouton_Connecter_pressed():
	if Global.is_connection:
		$Princ.hide();
		var scene = preload("res://menu/connexion.tscn")
		var instance = scene.instance()
		$Screen.add_child(instance)
	else:
		$Princ/NoConnection.visible=true

func _on_AudioStreamPlayer_finished():
	$AudioStreamPlayer.play()


func _on_bt_no_connexion_pressed():
	$Princ/NoConnection.visible=false
