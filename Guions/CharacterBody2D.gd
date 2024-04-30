extends CharacterBody2D


var SPEED = 700
const JUMP_VELOCITY = -1100
const ship_accel = 0.5
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var trail = $trail
@onready var animacio = $AnimatedSprite2D
@onready var rocket = $rocket



var is_exploding = false
var is_portal = false

func _ready():
	animacio.animation = "default"
	
func _physics_process(delta):
	if not is_exploding:
		if not is_portal:
			if not is_on_floor():
				velocity.y += gravity * delta
				trail.animation = "none"
			if is_on_floor():
				trail.animation = "default"
	
			if Input.is_action_pressed("ui_up") and is_on_floor():
				velocity.y = JUMP_VELOCITY
				var tween = create_tween()
				tween.tween_property($AnimatedSprite2D, "rotation_degrees", $AnimatedSprite2D.rotation_degrees - fmod($AnimatedSprite2D.rotation_degrees, 90) + 2*90, 0.6).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
			velocity.x = SPEED
		elif is_portal:
			if Input.is_action_pressed("ui_up"):
				velocity.y = ship_accel * JUMP_VELOCITY
				velocity.x = SPEED
				var tween = create_tween()
			else:
				velocity.y += gravity * delta
				var tween = create_tween()
	
		move_and_slide()
	
	if is_zero_approx(velocity.x):
		mor()


func mor():
	is_exploding = true
	trail.animation = "none"
	rocket.animation = "none"
	animacio.animation = "explosion"
	animacio.play()
	animacio.connect("animation_finished", _on_AnimatedSprite2D_animation_finished)
	
func _on_AnimatedSprite2D_animation_finished():
	animacio.disconnect("animation_finished",_on_AnimatedSprite2D_animation_finished)

	position = Vector2(100.25,position.y)

	animacio.animation = "default"
	animacio.play()
	is_exploding = false
	is_portal = false
	rocket.animation = "none"

func _on_portal_body_entered(portal):
	rocket.animation = "ship"
	is_portal = true

func _on_punxa_body_entered(punxa):
	mor()
	
