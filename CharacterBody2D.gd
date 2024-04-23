extends CharacterBody2D


var SPEED = 700
const JUMP_VELOCITY = -1100

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animacio = $AnimatedSprite2D
var is_exploding = false
var game_started = false

func _ready():
	animacio.animation = "default"
	game_started = true  # Set game_started to true here
	
func _physics_process(delta):
	# Add the gravity.
	if not is_exploding:
		if not is_on_floor():
			velocity.y += gravity * delta
	
		# Handle jump.
		if Input.is_action_pressed("ui_up") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		
		
			var tween = create_tween()
			tween.tween_property($AnimatedSprite2D, "rotation_degrees", $AnimatedSprite2D.rotation_degrees - fmod($AnimatedSprite2D.rotation_degrees, 90) + 2*90, 0.6).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
		velocity.x = SPEED
	 
		move_and_slide()
	
	if game_started and is_zero_approx(velocity.x):
		mor()

	# Set game_started to true after the first frame
	game_started = true


func mor():
	# Set the animation to 'explosion' and play it
	is_exploding = true
	animacio.animation = "explosion"
	animacio.play()

	# Connect the 'animation_finished' signal to a function
	animacio.connect("animation_finished", Callable(self, "_on_AnimatedSprite2D_animation_finished"))
	
func _on_AnimatedSprite2D_animation_finished():
	# This function will be called when the animation ends

	# Disconnect the signal to avoid it being triggered by other animations
	animacio.disconnect("animation_finished", Callable(self, "_on_AnimatedSprite2D_animation_finished"))

	# Reset the character position
	position = Vector2(100.25,position.y)

	# Set the animation back to 'default'
	animacio.animation = "default"
	animacio.play()
	is_exploding = false

func _on_area_2d_body_entered(body):
	if game_started:
		mor()
