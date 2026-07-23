extends CharacterBody2D
class_name Player

@export_group("Sprite")
@export var sprite: AnimatedSprite2D

@export_group("Energy")
@export var start_energy: float = 5.0

var current_energy: float = start_energy
var alive: bool = true

@export var energy_timer: Timer

@export_group("Movement")
@export var walk_speed: float = 15.0


var can_shoot: bool = true

const BULLET_RESOURCE = preload("res://scenes/bullet.tscn")


func _ready() -> void:
	walk_speed *= 1000


func _on_timer_timeout():

	if (current_energy <= 0.0):
		alive = false
		return

	current_energy -= energy_timer.wait_time
	if (current_energy < 0.0): current_energy = 0.0





func _physics_process(delta: float) -> void:
	

	var x_pressed: bool = false
	var y_pressed: bool = false	

	if ($ShootTimer.is_stopped()):
		$ShootTimer.start()
		can_shoot = true


	if (Input.is_action_pressed("move_up")):
		velocity.y = -walk_speed * delta
		y_pressed = true
	if (Input.is_action_pressed("move_left")):
		velocity.x = -walk_speed * delta
		x_pressed = true
	if (Input.is_action_pressed("move_down")):
		velocity.y = walk_speed * delta
		y_pressed = true
	if (Input.is_action_pressed("move_right")):
		velocity.x = walk_speed * delta
		x_pressed = true
	if (Input.is_action_pressed("shoot")):

		if (can_shoot):

			var bullet: Bullet = BULLET_RESOURCE.instantiate()
			bullet.position = position
			bullet.look_at(get_global_mouse_position())
			bullet.damage = 1.0
			$"..".add_child(bullet)
			can_shoot = false


	if (!x_pressed):
		velocity.x = 0.0
	if (!y_pressed):
		velocity.y = 0.0

	if (alive):
		move_and_slide()

	if (current_energy > 5.0):
		current_energy = 5.0
	elif (current_energy < 0.0):
		current_energy = 0.0
	

func subtract_energy(amount: float) -> void:
	if (!$IFrameTimer.is_stopped()): return
	current_energy -= amount
	$IFrameTimer.start()
