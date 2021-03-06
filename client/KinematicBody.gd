extends KinematicBody


var colors = [Color(1.0, 0.0, 0.0, 1.0),
		  Color(0.0, 1.0, 0.0, 1.0),
		  Color(0.0, 0.0, 1.0, 0.0)]

var curHp : int = 10
var maxHp : int = 10
var damage : int = 1

var attackRate : float = 0.3

var lastAttackTime : int = 0

var moveSpeed : float = 5.0
var jumpForce : float = 10.0
var gravity : float = 15.0

var vel : Vector3 = Vector3()

onready var camera = get_node("CameraPivot")
onready var attackRayCast = get_node("AttackRayCast")

func _ready():
	randomize()
	var color = colors[randi() % colors.size()]
	var mat = SpatialMaterial.new();
	mat.albedo_color = color;
	$Visuals/MeshInstance.set_surface_material(0, mat);
	
func _physics_process(delta):
	
	vel.x = 0
	vel.z = 0
	
	var input = Vector3()
	
	if Input.is_action_pressed("move_forward"):
		input.z += 1
	if Input.is_action_pressed("move_back"):
		input.z -= 1
	if Input.is_action_pressed("move_left"):
		input.x += 1
	if Input.is_action_pressed("move_right"):
		input.x -= 1
	
	# normalize the input vector to prevent increased diagonal
	input = input.normalized()
	
	# get the relative direction
	var dir = (transform.basis.z * input.z + transform.basis.x * input.x)
	
	# apply the direction to our velocity
	vel.x = dir.x * moveSpeed
	vel.z = dir.z * moveSpeed
	
	# gravity
	vel.y -= gravity * delta
	
	# jump
	if Input.is_action_pressed("jump") and is_on_floor():
		vel.y = jumpForce
	
	# move along the current velocity
	vel = move_and_slide(vel, Vector3.UP)





