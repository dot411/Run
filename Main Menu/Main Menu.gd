extends Node2D
var prev_page = [1]
var current_page = 1
func switch_to_page(page):
	var current_page_scene = get_node(str("Page", current_page))
	var new_page_scene = get_node(str("Page", page))
	current_page_scene.visible = false
	new_page_scene.visible = true
	current_page = page
	if page != 1:
		get_node("Back").visible = true
	else:
		get_node("Back").visible = false
func go_to_page(page):
	prev_page.push_front(current_page)
	switch_to_page(page)
func page_back():
	switch_to_page(prev_page[0])
	prev_page.pop_front()
func back_to_start():
	while prev_page.size() > 1:
		page_back()
func _on_Back_pressed():
	page_back()
