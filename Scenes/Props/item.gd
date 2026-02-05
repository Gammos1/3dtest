extends Node3D

func collision(a):
	$CollisionShape3D.disabled = not a
	
func get_collision():
	return $CollisionShape3D