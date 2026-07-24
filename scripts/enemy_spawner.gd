extends Node
class_name EnemySpawner


@export var enemy_resource: PackedScene
@export var enemy_count: int = 5
@export var enemy_distance: float = 1000.0


var enemies_left: int = 0

func on_enemy_killed():
	enemies_left -= 1


func spawn_enemy(position: Vector2):
	var enemy = enemy_resource.instantiate()
	enemy.position = position
	enemy.look_at($"../Player".position)
	$"..".add_child(enemy)
	enemy.connect("killed", on_enemy_killed)
	return enemy

func spawn_enemies(nodes: int, distance: float) -> void:

	var nodesDesired : int = nodes
	var a : float = (2.0 * PI) / float(nodesDesired)

	var max_distance: float = distance
	var radius: float = max_distance

	for i in nodesDesired:

		var pos := Vector2(cos(i * a) * radius, sin(i * a) * radius)

		pos.x += $"../Player".position.x
		pos.y += $"../Player".position.y
		
		var enemy = spawn_enemy(pos)
		var enemy_distance: float = enemy.position.distance_to($"../Player".position)

		if (enemy_distance < max_distance):
			enemy.position += enemy.position.rotated(enemy.rotation_degrees) * (max_distance - enemy_distance)


		spawn_enemies(enemy_count, enemy_distance)
