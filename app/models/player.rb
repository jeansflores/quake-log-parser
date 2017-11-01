class Player

	#
	# Modelo de player do projeto onde é dado o init da class Player e seus demais métodos
	#
	attr_accessor :name, :kills

	# Inicializa
	def initialize(name)
		@name = name
		@kills = 0
	end

	# Soma ao contador de kills do player
	def add_kills
		@kills += 1
	end

	# Decrementa o contadodor de kills do player
	def subtract_kills
		@kills -= 1
	end

end
