extends Node2D

func _on_level_pressed(level):
	start_level(level)
func start_level(level):
	var scene = load(str("res://Levels/", level, "/", "Scene.tscn"))
	var instance = scene.instance()
	instance.name = "Scene"
	var game_scene = get_node("/root/World/Game Scene")
	game_scene.add_child(instance)
	var parent = get_parent()
	parent.back_to_start()
	parent.visible = false
	game_scene.get_node("Player").init()
