extends Node

func instance_pre_transition():
	var pre_transition = load("res://Transition/Transition.tscn").instance()
	pre_transition.set("reversed", true)
	return pre_transition
func instance_end_transition():
	var end_transition = load("res://Transition/Transition.tscn").instance()
	return end_transition
