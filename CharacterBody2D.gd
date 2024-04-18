extends CharacterBody2D


var SPEED = 800
var min_SPEED = 799
const JUMP_VELOCITY = -1250

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	position.x += SPEED * delta
	 
	move_and_slide()
	
	if SPEED < min_SPEED:
		get_tree().change_scene_to_file("res://Escenes/game_over.tscn")
