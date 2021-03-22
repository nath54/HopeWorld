extends Spatial

var camrot_h = 0
var camrot_v = 0
var cam_v_min = -55
var cam_v_max = 75
var h_sensitivity = 0.5
var v_sensitivity = 0.5
var h_acceleration = 10
var v_acceleration = 10

onready var player = get_parent()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$h/v/Camera.add_exception(get_parent())

func _input(event):
	if player.en_pause:
		return
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("move_forward") or Input.is_action_pressed("move_back"):
			player.rotation_degrees.y += -event.relative.x * h_sensitivity
		else:
			camrot_h += -event.relative.x * h_sensitivity
		
		camrot_v += event.relative.y * v_sensitivity

func _physics_process(delta):
	if player.en_pause:
		return
	
	camrot_v = clamp(camrot_v, cam_v_min, cam_v_max)
	
	$h.rotation_degrees.y = lerp($h.rotation_degrees.y, camrot_h, delta * h_acceleration)
	$h/v.rotation_degrees.x = lerp($h/v.rotation_degrees.x, camrot_v, delta * v_acceleration)
