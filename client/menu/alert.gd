extends Control


func set_text(titre, message):
	$Titre.text = titre
	$Message.text = message


func _on_Button_pressed():
	queue_free()
