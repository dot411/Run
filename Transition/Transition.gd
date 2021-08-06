extends Node2D
var animation_speed = 1
export var end_color = Color(0, 0, 0, 0)
export var delay = 0
export var time = 1
export var reversed = false
export var inversed = false
signal finished
func _ready():
	var start_color = Color(0, 0, 0)
	if inversed:
		start_color = Color(1, 1, 1)
		get_node("ColorRect").color = start_color
		end_color = Color(1, 1, 1, 0)
	var timer = Timer.new()
	timer.name = "Timer"
	timer.set_one_shot(true)
	if reversed:
		start_color.a = 0
		get_node("ColorRect").color = start_color
	if time <= 0:
		time = 1
	time = time * animation_speed
	timer.set_wait_time(time)
	timer.set_autostart(true)
	if delay > 0:
		if reversed:
			start_color.a = 0
			get_node("ColorRect").color = start_color
		yield(get_tree().create_timer(delay), "timeout")
	add_child(timer)
	timer.connect("timeout", self, "_animation_finished")
	var Animation_Player = get_node("AnimationPlayer")
	var animation = Animation_Player.get_animation("Animation")
	animation.set_length(time)
	var track_index = animation.add_track(Animation.TYPE_VALUE)
	animation.track_set_path(track_index, "ColorRect:color")
	if reversed:
		if end_color == Color(0, 0, 0, 0):
			end_color = Color(0, 0 ,0)
		if inversed:
			end_color = Color(1, 1 ,1)
		start_color.a = 0
		animation.track_insert_key(track_index, 0.0, start_color)
		animation.track_insert_key(track_index, time, end_color)
	else:
		animation.track_insert_key(track_index, 0.0, start_color)
		animation.track_insert_key(track_index, time, end_color)
	Animation_Player.play("Animation")
func _animation_finished():
	emit_signal("finished")
	queue_free()
