extends KinematicBody

var en_pause = false

var colors = [Color(1.0, 0.0, 0.0, 1.0),
		  Color(0.0, 1.0, 0.0, 1.0),
		  Color(0.0, 0.0, 1.0, 0.0)]

var vie : int = 100
var vie_tot : int = 100
var damage : int = 1

var attackRate : float = 0.3
var lastAttackTime : int = 0

var moveSpeed : float = 17.0
var moveSpeedSprint : float = 32.0
var is_sprinting : bool = false
var stamina : float = 100.0
var stamina_max : float = 100.0
var last_sprint : float = OS.get_ticks_msec()
var time_before_fill_stamina : float = 1000 # en milisecondes
var stamina_fill_rate : float = 2
var stamina_run_rate : float = 3

var jumpForce : float = 6.0
var gravity : float = 15.0

var vel : Vector3 = Vector3()

var direction = Vector3.FORWARD


onready var camera = get_node("Camera")
onready var attackRayCast = get_node("AttackRayCast")

func _ready():
	randomize()
	var color = colors[randi() % colors.size()]
	var mat = SpatialMaterial.new();
	mat.albedo_color = color;
	$Visuals/MeshInstance.set_surface_material(0, mat);
	#ui
	$player_ui.player = self
	$player_ui.set_life()

func _input(event):
	if Input.is_action_just_pressed("sprint"):
		if stamina > 0:
			is_sprinting = true
			last_sprint = OS.get_ticks_msec()
	if Input.is_action_just_released("sprint"):
		if is_sprinting:
			is_sprinting = false
			last_sprint = OS.get_ticks_msec()

func _physics_process(delta):
	if en_pause:
		return

	vel.x = 0
	vel.z = 0
	
	var input = Vector3()
	
	input = Vector3(Input.get_action_strength("move_left") - Input.get_action_strength("move_right"),
						0,
						Input.get_action_strength("move_forward") - Input.get_action_strength("move_back"))

	
	# normalize the input vector to prevent increased diagonal
	input = input.normalized()
	
	# get the relative direction
	var dir = (transform.basis.z * input.z + transform.basis.x * input.x)
	
	var speed = moveSpeed
	if is_sprinting:
		stamina -= stamina_run_rate * delta
		if stamina <= 0:
			stamina = 0
			is_sprinting = false
			last_sprint = OS.get_ticks_msec()
		$player_ui.set_stamina()
	if is_sprinting:
		speed = moveSpeedSprint
	elif OS.get_ticks_msec()-last_sprint > time_before_fill_stamina:
		if stamina < stamina_max:
			stamina += stamina_fill_rate * delta
			if stamina > stamina_max:
				stamina = stamina_max
			$player_ui.set_stamina()
	
	
	# apply the direction to our velocity
	vel.x = dir.x * speed
	vel.z = dir.z * speed
	
	# gravity
	vel.y -= gravity * delta
	
	# jump
	if Input.is_action_pressed("jump") and is_on_floor():
		vel.y = jumpForce
	
	# cam
	if Input.is_action_pressed("move_forward") or Input.is_action_pressed("move_back"):
		if abs($Camroot.camrot_h) > 0:
			rotation_degrees.y+=$Camroot.camrot_h*0.1
			$Camroot.camrot_h*=0.9
	
	# move along the current velocity
	vel = move_and_slide(vel, Vector3.UP)

func pause():
	en_pause = true

func resume():
	en_pause = false

