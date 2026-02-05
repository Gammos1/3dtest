extends StaticBody3D

@export var isOpen := false
@onready var player := get_node("../../../Door")

func open():
	if not isOpen and not player.is_playing():
		player.play("open")
		isOpen = true
	elif not player.is_playing():
		close()

func close():
	if isOpen:
		player.play_backwards("open")
		isOpen = false
