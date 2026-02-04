extends Camera

export var mouse_sensitivity := 0.1
var escaped := false

func _ready() -> void:
	set_as_toplevel(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and not escaped:
		rotation_degrees.x -= event.relative.y * mouse_sensitivity
		rotation_degrees.x = clamp(rotation_degrees.x, -90.0, 90.0)
		
		rotation_degrees.y -= event.relative.x * mouse_sensitivity
		rotation_degrees.y = wrapf(rotation_degrees.y, 0.0, 360.0)

func _process(delta):
	if Input.is_action_just_released("ui_cancel") and not escaped:
		escaped = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif Input.is_action_just_released("ui_cancel") and escaped:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		escaped = false