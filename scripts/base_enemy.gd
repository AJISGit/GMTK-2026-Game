extends CharacterBody2D
class_name Enemy


@export_group("Sprite")
@export var sprite: AnimatedSprite2D

@export_group("Health")
@export var max_health: int = 5
var health: int = max_health

var alive: bool = true

@export_group("Movement")
@export var walk_speed: float = 15.0

@export_group("Damage")
@export var body_damage: float = 1.0

@export_group("Energy")
@export var energy: float = 5.0


signal killed


func _ready() -> void:
	walk_speed *= 1000

func _physics_process(delta: float) -> void:

	if (health < 0):
		$"../Player".current_energy += energy
		killed.emit()
		queue_free()

	look_at($"../Player".position)

	velocity = Vector2(1.0, 0.0).rotated(rotation) * walk_speed * delta
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:

	if (body == $"../Player"):
		body.subtract_energy(body_damage)
		velocity = Vector2(1.0, 0.0).rotated(rotation) * 300
		velocity = -velocity
		move_and_slide()
