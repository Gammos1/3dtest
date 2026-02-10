extends Node3D

var holding

func take(node):
	if (holding == null):
		node.get_parent().remove_child(node)
		call_deferred("add_child", node)
		node.position = Vector3.ZERO
		node.rotation_degrees = Vector3.ZERO
		if node is RigidBody3D:
			node.collision(false)
			node.freeze = true
		holding = node

func drop():
	var WORLD := get_tree().current_scene
	if not (holding == null):
		remove_child(holding)
		WORLD.get_node("dropped_items").add_child(holding)
		holding.set_global_transform($drop_position.get_global_transform())
		if holding is RigidBody3D:
			holding.collision(true)
			holding.linear_velocity = Vector3.ZERO
			holding.angular_velocity = Vector3.ZERO
			holding.freeze = false
		holding = null
