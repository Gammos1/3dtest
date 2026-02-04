extends StaticBody

export var open := false
onready var door := get_parent()
onready var player := get_node("../../../Door")

func _open():
	if not open and not player.is_playing():
		player.play("open")
		open = true
	elif not player.is_playing():
		_close()

func _close():
	if open:
		player.play_backwards("open")
		open = false