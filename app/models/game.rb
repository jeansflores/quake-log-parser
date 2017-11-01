class Game
	#
	# Modelo de game do projeto onde é dado o init da class Game e seus demais métodos
	#
	attr_accessor :id, :total_kills, :players, :means_of_death

	def initialize(id)
		@id = id
		@total_kills = 0
		@players = Hash.new
		@means_of_death =  Hash.new(0)
	end

	#
	# Adiciona mais ao contador de kills do game (partida)
	#
	def add_total_kill
		@total_kills += 1
	end

end
