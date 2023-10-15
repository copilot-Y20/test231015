extends RigidBody2D

@onready var animations = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("walkDown")
	
func _physics_process(delta):
	updateAnimation()


func updateAnimation():
	var velocity = self.get_linear_velocity()
	if velocity.length() == 0:
		if animations.is_playing():
			animations.stop()
	else:
		var direction = "Right"
		if velocity.x >= 0 and abs(velocity.x) >= abs(velocity.y): direction = "Right"
		elif velocity.x <= 0 and abs(velocity.x) >= abs(velocity.y): direction = "Left"
		elif velocity.y >= 0 and abs(velocity.y) >= abs(velocity.x): direction = "Down"
		elif velocity.y <= 0 and abs(velocity.y) >= abs(velocity.x): direction = "Up"
		else: print("something wrong")
		animations.play("walk" + direction)
		print('direction')
		print(direction)




