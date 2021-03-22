extends Spatial

var lookSensitivity : float = 15.0
var minLookAngle : float = -40.0
var maxLookAngle : float = 65.0

var mouseDelta : Vector2 = Vector2()

onready var player = get_parent()

onready var base_position = $Camera.translation

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if player.en_pause:
		return

	if event is InputEventMouseMotion:
		mouseDelta = event.relative;

func _process(delta):
	if player.en_pause:
		return

	var rot = Vector3(mouseDelta.y, mouseDelta.x, 0) * lookSensitivity * delta
	
	rotation_degrees.x += rot.x
	rotation_degrees.x = clamp(rotation_degrees.x, minLookAngle, maxLookAngle)
	
	player.rotation_degrees.y -= rot.y
	
	mouseDelta = Vector2()

func _physics_process(delta):
	if $Ray_cam.get_collider()!=null:
		var position = $Ray_cam.get_collision_point()
		$Camera.translate(position)
	elif $Camera.translation!=base_position:
		$Camera.translate(base_position)

