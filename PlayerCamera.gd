extends Camera3D

@export var mouse_sensitivity := 0.1
var escaped := false

func _ready() -> void:
	set_as_top_level(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and not escaped:
		rotation_degrees.x -= event.relative.y * mouse_sensitivity
		rotation_degrees.x = clamp(rotation_degrees.x, -90.0, 90.0)
		
		rotation_degrees.y -= event.relative.x * mouse_sensitivity
		rotation_degrees.y = wrapf(rotation_degrees.y, 0.0, 360.0)
		
		get_parent().get_node("Pivot").rotation_degrees.y = rotation_degrees.y
		get_parent().get_node("Pivot").rotation_degrees.x = rotation_degrees.x
		
		
	if Input.is_action_just_released("f11"):
		if (((get_window().mode == Window.MODE_EXCLUSIVE_FULLSCREEN) or (get_window().mode == Window.MODE_FULLSCREEN))):
			get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (false) else Window.MODE_WINDOWED
		else:
			get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (true) else Window.MODE_WINDOWED

func _process(_delta):
	if Input.is_action_just_released("ui_cancel") and not escaped:
		escaped = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif Input.is_action_just_released("ui_cancel") and escaped:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		escaped = false
