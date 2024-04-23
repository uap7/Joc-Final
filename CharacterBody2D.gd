extends CharacterBody2D


var SPEED = 700
const JUMP_VELOCITY = -1100

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
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
	
	if is_zero_approx(velocity.x):
		mor()

func mor():
	print('Uix: %.2f' % [velocity.x])
