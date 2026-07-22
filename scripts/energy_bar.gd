extends AnimatedSprite2D


func _process(_delta: float) -> void:

	var energy: float = %Player.current_energy
	var energy_frame: float = energy * 4.3 
	frame = floor(energy_frame)

	var energy_whole: int = int(energy)
	var energy_decimal: float = energy - energy_whole

	$"../EnergyLabel".text = str(energy_whole) + ':' + str(int(energy_decimal * 100))
	
