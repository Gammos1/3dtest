extends KinematicBody

export var speed := 2.0
#export var jump_strength := 2.5
export var gravity := 9.81
export var sprint_speed := 2.0
export var ctrl_speed := 9.0
export var camera_height := 1.7

var _velocity := Vector3.ZERO
var _snap_vector := Vector3.DOWN

var camera_offset := 0.0

onready var _camera: Camera = $Camera
onready var raycast := $Camera/RayCast


func _physics_process(delta: float) -> void:
	var move_direction := Vector3.ZERO
	move_direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	move_direction.z = Input.get_action_strength("back") - Input.get_action_strength("forward")
	move_direction = move_direction.rotated(Vector3.UP, _camera.rotation.y).normalized()
	
	var sprint := 0.0
	if Input.is_action_pressed("shift"):
		sprint = sprint_speed
	else:
		sprint = 0.0
	
	_velocity.x = move_direction.x * (speed + sprint)
	_velocity.z = move_direction.z * (speed + sprint)
	_velocity.y -= gravity * delta
	
	#var just_landed := is_on_floor() and _snap_vector == Vector3.ZERO
	#var is_jumping := is_on_floor() and Input.is_action_pressed("jump")
	#if is_jumping:
	#	_velocity.y = jump_strength
	#	_snap_vector = Vector3.ZERO
	#elif just_landed:
	#	_snap_vector = Vector3.DOWN
	_velocity = move_and_slide_with_snap(_velocity, _snap_vector, Vector3.UP, true)
	
	if raycast.is_colliding():
		if raycast.get_collider().is_in_group("takable"):
			if raycast.get_collider().is_in_group("take_side"):
				if Input.is_action_just_released("click"):
					$Camera/holding_side.take(raycast.get_collider())
		if raycast.get_collider().is_in_group("interactable"):
			hud_showHand(true)
			if raycast.get_collider().is_in_group("door"):
				if Input.is_action_just_released("click"):
					raycast.get_collider().open()
		else:
			hud_showHand(false)
	else:
		hud_showHand(false)
		
	if Input.is_action_just_released("rclick"):
		$Camera/holding_side.drop()



func _process(delta: float) -> void:
	if Input.is_action_pressed("ctrl"):
		camera_offset = camera_height - 0.700001
	else:
		camera_offset = camera_height + (translation.y/2 - 0.675249)

	_camera.translation.x = translation.x
	_camera.translation.z = translation.z
	_camera.translation.y = lerp(_camera.translation.y, camera_offset, ctrl_speed * delta)


func hud_showHand(show):
	if show:
		$HUD/Ring.visible = false
		$HUD/Hand.visible = true
	else:
		$HUD/Ring.visible = true
		$HUD/Hand.visible = false

