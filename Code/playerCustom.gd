extends CharacterBody3D
#move cam w/ mouse
#move player w/ keyboard
#constrain mouse
#jump
#capture mouse

func _unhandled_input(event: InputEvent) -> void: 
	
	if event is InputEventMouseMotion:
		#rotate player
		rotation_degrees.y -= event.screen_relative.x * .5
		#roatate up and down camera
		%Camera3D.rotation_degrees.x -= event.screen_relative.y * .2
		%Camera3D.rotation_degrees.x = clamp(%Camera3D.rotation_degrees.x, -80, 80)

func _physics_process(delta: float) -> void:
	const SPEED = 5.5 #meters per second
	#walk
	var input_direction_2D = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	#make 2d vector into 3d 
	var input_direction_3D = Vector3(input_direction_2D.x, 0, input_direction_2D.y)
	
	#this basis is player's current roation
	var direction = transform.basis * input_direction_3D
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	#jumping
	#gravity
	#y direction
	move_and_slide()
