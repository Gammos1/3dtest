extends Spatial

var holding

func take(node):
	if (holding == null):
		node.get_parent().remove_child(node)
		call_deferred("add_child", node)
		node.translation = Vector3.ZERO
		node.rotation_degrees = Vector3.ZERO
		node.collision(false)
		node.sleeping = false
		holding = node

func drop():
	var WORLD := get_tree().current_scene
	if not (holding == null):
		remove_child(holding)
		WORLD.get_node("dropped_items").add_child(holding)
		holding.set_global_transform($drop_position.get_global_transform())
		holding.collision(true)
		holding.linear_velocity = Vector3.ZERO
		holding.angular_velocity = Vector3.ZERO
		holding.sleeping = false
		print(holding.sleeping)
		holding = null