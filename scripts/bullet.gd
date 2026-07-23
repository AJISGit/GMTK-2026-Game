extends Area2D
class_name Bullet


var speed: float = 200.0
var damage: float = 0.1
var from_plr: bool = true

func _physics_process(delta: float) -> void:
	position += Vector2(1.0, 0.0).rotated(rotation) * speed * delta

func _on_body_entered(body: Node2D):
	if (body == $"../Player"):
		if (from_plr): return
		body.subtract_energy(damage)
	else:
		if (!(body as Enemy)): pass
		body.health -= damage

	queue_free()
