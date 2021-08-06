extends Node2D
var input_enabled = false
var velocity = 0
var angle = 0
var acceleration = 0.1
var friction = 0.03
#var spin_v = 0
var max_v = 20
var min_v = -20
var up_pressed = false
var down_pressed = false
var left_pressed = false
var right_pressed = false
func init():
	visible = true
	input_enabled = true
	up_pressed = false
	down_pressed = false
	left_pressed = false
	right_pressed = false
func rotate_coord(center, angle, coord):
	while angle < 0:
		angle += 2 * PI
	while angle > 2 * PI:
		angle -= 2 * PI
	var x = cos(angle) * (coord.x - center.x) - sin(angle) * (coord.y - center.y) + center.x
	var y = sin(angle) * (coord.x - center.x) + cos(angle) * (coord.y - center.y) + center.y
	if x == -0: x = 0
	if y == -0: y = 0
	return Vector2(x, y)
func _process(delta):
	if !input_enabled: return
	if Input.is_action_pressed("up"):
		up_pressed = true
	if Input.is_action_pressed("down"):
		down_pressed = true
	if Input.is_action_pressed("left"):
		left_pressed = true
	if Input.is_action_pressed("right"):
		right_pressed = true
	if Input.is_action_just_released("up"):
		up_pressed = false
	if Input.is_action_just_released("down"):
		down_pressed = false
	if Input.is_action_just_released("left"):
		left_pressed = false
	if Input.is_action_just_released("right"):
		right_pressed = false
	var body = get_node("Body")
	if up_pressed and velocity < max_v:
		velocity += acceleration
	if down_pressed and velocity > min_v:
		velocity -= acceleration
	if left_pressed:
		body.rotation_degrees -= 2
	if right_pressed:
		body.rotation_degrees += 2
	angle = 2*PI * body.rotation_degrees / 360.0
	var v = rotate_coord(Vector2(0, 0), angle, Vector2(velocity, 0))
	var collision = body.move_and_collide(v)
	if collision != null:
		velocity = 0
		lose()
	if velocity > 0:
		velocity -= friction
func lose():
	end()
func end():
	get_node("Body").position = Vector2(500, 300)
	input_enabled = false
	visible = false
	var menu = get_node("/root/World/Main Menu")
	menu.visible = true
	get_parent().get_node("Scene").free()
