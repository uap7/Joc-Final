extends CharacterBody2D

var attempts = 1

var SPEED = 700
const JUMP_VELOCITY = -1100
const ship_accel = 0.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var trail = $trail
@onready var animacio = $AnimatedSprite2D
@onready var rocket = $rocket
@onready var trail_2 = $trail2
@onready var audio = $AudioStreamPlayer2D
@onready var winner = $Win

var mor_menu = false
var is_exploding = false
var is_portal = false
var is_portal_g = false
var winning = false

func _ready():
	animacio.animation = "default"
	winner.animation = "none"
	velocity.x = SPEED
	
func jump():
	velocity.y = -1500

func _physics_process(delta):
	if not is_exploding:
		if not winning:
			if not is_portal:
				if not is_portal_g:
					if not is_on_floor():
						velocity.y += gravity * delta
						trail.animation = "none"
						trail_2.animation = "none"
					if is_on_floor():
						trail.animation = "default"
						trail_2.animation = "none"
	
					if Input.is_action_pressed("ui_up") and is_on_floor():
						velocity.y = JUMP_VELOCITY
						var tween = create_tween()
						tween.tween_property($AnimatedSprite2D, "rotation_degrees", $AnimatedSprite2D.rotation_degrees - fmod($AnimatedSprite2D.rotation_degrees, 90) + 2*90, 0.6).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
				elif is_portal_g:
					if not is_on_ceiling():
						velocity.y += (-gravity) * delta
						trail_2.animation = "none"
						trail.animation = "none"
					if is_on_ceiling():
						trail_2.animation = "default"
						trail.animation = "none"
	
					if Input.is_action_pressed("ui_up") and is_on_ceiling():
						velocity.y = -JUMP_VELOCITY
						var tween = create_tween()
						tween.tween_property($AnimatedSprite2D, "rotation_degrees", $AnimatedSprite2D.rotation_degrees - fmod($AnimatedSprite2D.rotation_degrees, -90) + 2*(-90), 0.6).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
						#var tween = create_tween()
						#tween.tween_property($AnimatedSprite2D, "rotation_degrees", $AnimatedSprite2D.rotation_degrees - fmod($AnimatedSprite2D.rotation_degrees, 50), 0.6).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
					
				velocity.x = SPEED
			elif is_portal:
				if Input.is_action_pressed("ui_up"):
					velocity.y = ship_accel * JUMP_VELOCITY
					velocity.x = SPEED
					trail.animation = "none"
					trail_2.animation = "none"
				
				else:
					velocity.y += gravity * delta
	
			move_and_slide()
	
		if is_zero_approx(velocity.x):
			mor()
		
		if Input.is_action_just_pressed("ui_cancel"):
			mor_menu = true
			mor()

func mor():
	is_exploding = true
	is_portal_g = false
	trail.animation = "none"
	rocket.animation = "none"
	audio.stop()
	audio.play()
	animacio.animation = "explosion"
	animacio.play()	
	animacio.connect("animation_finished", _on_AnimatedSprite2D_animation_finished)
	
func _on_AnimatedSprite2D_animation_finished():
	animacio.disconnect("animation_finished",_on_AnimatedSprite2D_animation_finished)
	if mor_menu == false:
		position = Vector2(-4698,position.y)
		animacio.animation = "default"
		animacio.play()
		is_exploding = false
		is_portal = false
		rocket.animation = "none"
	elif mor_menu == true:
		audio.stop()
		get_tree().change_scene_to_file("res://Escenes/Menu.tscn")
		mor_menu = false

func portal():
	rocket.animation = "ship"
	is_portal = true
	is_portal_g = false

func portal_g():
	is_portal = false
	is_portal_g = true
	rocket.animation = "none"
	
func portal_normal():
	is_portal = false
	is_portal_g = false
	rocket.animation = "none"

func win():
	winning = true
	winner.animation = "default"
	animacio.animation = "none"

func _on_win_animation_finished():
	get_tree().change_scene_to_file("res://felicitaciófons.tscn")
	animacio.animation = "default"
	winner.animation = "none"
