extends Node2D

@export var mob_scene: PackedScene
var score

@onready var heartsContainer = $CanvasLayer/heartsContainer
@onready var player = $TileMap/Player
var mobNumber = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	heartsContainer.setMaxHearts(player.maxHealth)
	heartsContainer.updateHearts(player.currentHealth)
	player.healthChanged.connect(heartsContainer.updateHearts)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_inventory_gui_closed():
	get_tree().paused = false

func _on_inventory_gui_opened():
	get_tree().paused = true

func new_game():
	print("new_game")
	$MusicTimer.start()
	$StartTimer.start()

func _on_start_timer_timeout():
	$MobTimer.start()
	
func _on_mob_timer_timeout():
	if mobNumber < 10:
		var mob = mob_scene.instantiate()

		# Choose a random location on Path2D.
		var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
		mob_spawn_location.progress_ratio = randf()

		# make the spwan location fixed
#		mob_spawn_location.progress_ratio = 0.5
		
		# Set the mob's direction perpendicular to the path direction.
		var direction = mob_spawn_location.rotation + PI / 2 
#		var direction = mob_spawn_location.rotation 

		# Set the mob's position to a random location.
		mob.position = mob_spawn_location.position

		# Add some randomness to the direction.
		direction += randf_range(-PI / 4, PI / 4)
		mob.rotation = direction

		# Choose the velocity for the mob.
		var velocity = Vector2(randf_range(5.0, 5.0), 0.0)
		mob.linear_velocity = velocity.rotated(direction)


		# Spawn the mob by adding it to the Main scene.
		add_child(mob)
		mobNumber += 1
	else:
		print("mobNumber out limit")
		pass

func _on_music_timer_timeout():
	$Music.play()
