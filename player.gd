extends CharacterBody2D

@export var projectile_scene:PackedScene = load("res://shot.tscn")
@onready var left_eye = $LeftEye
@onready var right_eye = $RightEye
const SPEED = 300.0

func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * SPEED

func _physics_process(delta):
	get_input()
	move_and_slide()


func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			var left_shot:Area2D = projectile_scene.instantiate()
			var right_shot:Area2D = projectile_scene.instantiate()
			var mouse_pos = event.global_position
			print(mouse_pos)
			print(get_global_mouse_position())
			#print(mouse_pos.normalized())
			get_parent().add_child(left_shot)
			get_parent().add_child(right_shot)
			left_shot.position = left_eye.global_position
			right_shot.position = right_eye.global_position
			left_shot.direction = Vector2((mouse_pos - left_eye.global_position)).normalized()
			right_shot.direction = Vector2((mouse_pos - right_eye.global_position)).normalized()
			#left_shot.direction = Vector2.UP
			#left_shot.rotation = rad_to_deg(left_eye.global_position.angle_to_point(mouse_pos))
			#print(left_eye.position.look)
			var left_angle = rad_to_deg(left_eye.position.angle_to(mouse_pos))
			print(left_angle)
			#right_shot.rotation = rad_to_deg(right_eye.global_position.angle_to_point(mouse_pos))
			left_shot.look_at(mouse_pos)
			left_shot.rotation -= 90.0
			right_shot.look_at(mouse_pos)
			right_shot.rotation -= 90.0
			#left_shot.look_at(get_global_mouse_position())
			#right_shot.rotation = rad_to_deg(get_local_mouse_position().angle())
			#print(right_shot.rotation)
			
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_RIGHT:
			print("BIG BLAST")
