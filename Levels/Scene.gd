extends Node2D
export var flood_speed = 1
func _process(delta):
	var player = get_node("/root/World/Game Scene/Player")
	if !player.get("input_enabled"): return
	var flood = get_node("Flood")
	var sprite = flood.get_node("Body/ColorRect")
	sprite.rect_size.y += flood_speed
	flood.get_node("Body/CollisionShape2D").position.y += flood_speed
