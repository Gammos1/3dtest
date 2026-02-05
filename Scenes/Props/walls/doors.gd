extends StaticBody

export var open := false
onready var player := get_node("../../../Door")

func open():
	if not open and not player.is_playing():
		player.play("open")
		open = true
	elif not player.is_playing():
		close()

func close():
	if open:
		player.play_backwards("open")
		open = false