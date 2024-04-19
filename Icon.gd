extends Sprite2D


var SPEED = 700
const JUMP_VELOCITY = -1500

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	position.x += SPEED * delta
	
	
