extends Spatial

func collision(a):
	$CollisionShape.disabled = not a
	
func get_collision():
	return $CollisionShape